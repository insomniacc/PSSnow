<#
.SYNOPSIS
    Retrieves the current state of a ServiceNow web session.

.DESCRIPTION
    The Get-SNOWWebSessionState function examines and returns detailed information about the current
    ServiceNow web session, including token validity, cookie information, and authentication status.
    
    This function helps diagnose authentication issues and verifies that a session is properly 
    established before making API calls to ServiceNow.
    
    When validation is requested, it makes a test API call to 
    /api/now/v2/table/sys_user to verify the session is active and authenticated.

.PARAMETER ValidateSession
    When specified, performs a live validation by making a test API call to ServiceNow
    to confirm the session is active and authenticated. This will retrieve the current
    user information to verify proper authorization.

.EXAMPLE
    PS> Get-SNOWWebSessionState
    
    Returns basic information about the current web session without making any validation calls.
    Shows security token status, cookie validity, and expiration information.

.EXAMPLE
    PS> Get-SNOWWebSessionState -ValidateSession
    
    Returns detailed session state information and validates the session by making a test 
    API call to verify authentication. Includes current user information in the output.

.NOTES
    This function requires a valid ServiceNow session established via Set-SNOWAuth or 
    New-SNOWAuthWebSession before use.
    
    The session state includes details about:
    - Security token validity
    - Cookie expiration times
    - Authentication status
    - User information (when validation is performed)
#>
function Get-SNOWWebSessionState {
    
    param (
        [Parameter()]
        [switch]
        $ValidateSession
    )

    # Check if SNOWAuth contains session information
    if (-not $Script:SNOWAuth -or -not $Script:SNOWAuth.session) {
        Write-Warning "Get-SNOWWebSessionState: Session information is missing from SNOWAuth."
        return $null
    }
    function resolveBaseState() {
        # Determine the time of the next cookie expiration
        $nextExpiration = $Script:SNOWAuth.session.WebSession.Cookies.GetCookies("https://$($Script:SNOWAuth.Instance).service-now.com") |
        Where-Object { -not $_.Expired } |
        Where-Object { $_.Expires -gt [datetime]'1/1/0001' } |
        Sort-Object -Property Expires |
        Select-Object -First 1 -ExpandProperty Expires
        # Create session info object
        $SessionState = [PSCustomObject]@{
            Instance             = $Script:SNOWAuth.Instance
            HasSecurityToken     = -not [string]::IsNullOrEmpty($Script:SNOWAuth.session.g_ck)
            SecurityToken        = $Script:SNOWAuth.session.g_ck
            CookieCount          = $Script:SNOWAuth.session.WebSession.Cookies.Count
            CookiesValid         = ($Script:SNOWAuth.session.WebSession.Cookies | Where-Object { $_.Expired } | Measure-Object).Count -eq 0
            CookieString         = $Script:SNOWAuth.session.WebSession.Cookies.GetCookieHeader("https://$($Script:SNOWAuth.Instance).service-now.com")
            Valid                = $false
            ValidationMessage    = "Session not validated"
            Expired              = ($Script:SNOWAuth.session.Expires -lt (Get-Date))
            StatusCode           = 0
            User                 = $null
            NextCookieExpiration = $nextExpiration
        }
       
        # If cookies expire within 5 minutes, set session to invalid. Assert-SnowAuth will re-authenticate if neccessary.
        if ($nextExpiration -and $nextExpiration -lt ([datetime]::Now).AddSeconds(30)) {
            $SessionState.CookiesValid = $false
            $SessionState.Valid = $false
            $SessionState.ValidationMessage = "Cookies are about to expire within 30 seconds. $($nextExpiration.ToString('yyyy-MM-dd HH:mm:ss'))"
            Write-Verbose "PSSnow WebSession Cookies are about to expire within 30 seconds. Instance: $($SessionState.Instance) $($nextExpiration.ToString('yyyy-MM-dd HH:mm:ss'))"
        }

        return $SessionState
    }
    $SessionState = resolveBaseState
    if ($SessionState.SecurityToken -and $SessionState.CookiesValid) {
        $SessionState.Valid = $true
    }
    # If ValidateSession is specified, make a test API call
    if ($ValidateSession -and $SessionState.CookiesValid) {
        $ValidateRequests = @(
            @{
                'key' = 'User'
                'url' = '/api/now/v2/table/sys_user?sysparm_limit=1&sysparm_fields=sys_id,name,user_name&sysparm_query=user_name=javascript:gs.getUserName()'
            }
        )
        
        foreach ($req in $ValidateRequests) {
            Write-Verbose "Get-SNOWWebSessionState - ValidateSession calling $($req.url)"
            $vReq = @{
                Uri             = "https://$($Script:SNOWAuth.Instance).service-now.com$($req.url)"
                Method          = "GET"
                WebSession      = $Script:SNOWAuth.session.WebSession
                UseBasicParsing = $true
                Headers         = @{
                    'X-UserToken' = $Script:SNOWAuth.session.g_ck
                }
            }

            # Add proxy settings if present
            if ($Script:SNOWAuth.ProxyAuth) {
                foreach ($key in $Script:SNOWAuth.ProxyAuth.Keys) {
                    $vReq[$key] = $Script:SNOWAuth.ProxyAuth[$key]
                }
            }
            $response = try {
                if ($PSVersionTable.PSEdition -eq 'Core') {
                    $vReq['SkipHttpErrorCheck'] = $true
                }
                (Invoke-WebRequest @vReq -ErrorAction Stop)
            }
            catch [System.Net.WebException] { 
                Write-Verbose "An exception was caught: $($_.Exception.Message)"
                $_.Exception.Response 
            }
            
            #then convert the status code enum to int by doing this
            $statusCodeInt = [int]$response.StatusCode

            $SessionState.Valid = ($statusCodeInt -eq 200)
            $SessionState.StatusCode = $statusCodeInt
            try {
                $responseData = ($response.Content | ConvertFrom-Json)
                
                if ($responseData.status -eq 'failure') {
                    $SessionState."$($req.key)" = $responseData
                    $SessionState.ValidationMessage = $response.Content
                }
                elseif ($responseData.result) {
                    $SessionState."$($req.key)" = $responseData.result
                    $SessionState.ValidationMessage = "Session is valid and authenticated"
                }
                else {
                    Write-Error "Session is valid but no result found in response for $($req.url)" -ErrorAction Stop
                }
            }
            catch {
                Write-Verbose "Could not parse $($req.id)response as JSON"
                $SessionState.ValidationMessage = $_.Exception.Message
            }
            if (-not $SessionState.Valid) {
                break
            }
        }
    }
    $Script:SNOWAuth.SessionState = $SessionState
    return $SessionState
}
