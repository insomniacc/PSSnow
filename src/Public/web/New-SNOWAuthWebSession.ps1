<#
    .SYNOPSIS
    Creates an authenticated web session to ServiceNow using credentials from SNOWAuth.

    .DESCRIPTION
    This function creates an authenticated web session using two possible methods:

    Method 1 - Via get_publish_info endpoint:
    1. Makes a GET request to /sn_devstudio_/v1/get_publish_info endpoint using a WebSession
    2. Extracts the cK token from the response JSON under 'ck' property
    3. Extract the JSESSIONID and glide_* cookies from the response

    Method 2 - Via form login:
    1. Performs initial GET request to /login.do to obtain session cookies and initial security token (in hidden input field)
    2. Submits POST request to /login.do with credentials in form data
    3. Extracts cK token by searching for 'g_ck = ' pattern in the response JavaScript
    4. The token is typically found between quotes after 'g_ck = ' declaration

    This function requires that Set-SNOWAuth has been run first to set credentials.

    .EXAMPLE
    New-SNOWAuthWebSession

    .NOTES
    Both methods achieve the same result of obtaining a valid cK token:
    - Method 1 (get_publish_info) is faster but requires existing authentication
    - Method 2 (form login) works without prior authentication but requires multiple requests
    - The cK token is used along with cookies to authenticate subsequent requests
    - This function uses credentials stored in $Script:SNOWAuth
    #>
function New-SNOWAuthWebSession {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    Param()
    begin {
        # Check if SNOWAuth is set
        if (-not $Script:SNOWAuth) {
            Write-Warning "SNOWAuth is not set. Please run Set-SNOWAuth first."
            return $null
        }
    }
    process {
        $Credential = $Script:SNOWAuth.Credential
        # Create session state tracking object
        $SnowSession = @{
            g_ck    = $null
            valid   = $false
            Created = (Get-Date)
        }
        $WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
        $PublishRequest = @{
            Uri    = "sn_devstudio_/v1/get_publish_info"
            Method = 'GET'
        }
        $Script:PSDefaultParameterValues['Invoke-RestMethod:WebSession'] = $WebSession
        $Script:PSDefaultParameterValues['Invoke-WebRequest:WebSession'] = $WebSession
        $Script:PSDefaultParameterValues['Invoke-WebRequest:MaximumRedirection'] = 0
        $PublishResponse = try {
            (Invoke-SNOWWebRequest @PublishRequest)
        }
        catch { 
            if ($_.Exception.Response.StatusCode -eq 401) {
                Write-Warning "Authentication failed. Please check your credentials."
                if (!$Script:SNOWAuth.Credentials) {
                    Write-Warning "No credentials provided. Unable to authenticate."
                    return $null
                }
            }
            elseif($_.Exception.Response.StatusCode -eq 302) {
                Write-Warning "302 response received. API Endpoint may be missing @ $($PublishRequest.Uri)"
            }
            $_.Exception.Response 
        }
        finally {
            # Reset default parameters
            $Script:PSDefaultParameterValues['Invoke-RestMethod:WebSession'] = $null
            $Script:PSDefaultParameterValues['Invoke-WebRequest:WebSession'] = $null
            # Reset maximum redirection - Default is 5 according to Microsoft Docs
            $Script:PSDefaultParameterValues['Invoke-WebRequest:MaximumRedirection'] = 5
        }
        
        # Check if the response is valid
        if ($PublishResponse.StatusCode -eq 200) {
            $PublishReponseObject = try { $PublishResponse.Content | ConvertFrom-Json -ErrorAction SilentlyContinue } catch { 
                Write-Warning "Failed to parse JSON response from $($PublishRequest.Uri) $($_.Exception.Message)"
                $null
             }
            if ($PublishReponseObject.ck) {
                Write-Verbose "Got ck token from sn_devstudio_/v1/get_publish_info: $($PublishReponseObject.ck.Substring(0, 10))..."
                $WebSession.Credentials = $null # Clear credentials now that we have a valid session
                if ($WebSession.Headers['Authorization']) {
                    [void]$WebSession.Headers.Remove('Authorization')
                }
                $SnowSession.g_ck = $PublishReponseObject.ck
                $SnowSession.valid = $true
                $WebSession.Headers['X-UserToken'] = $PublishReponseObject.ck
                $SnowSession.WebSession = $WebSession
                $SnowSession.Expires = (Get-Date).AddMinutes(45)
                return $SnowSession
            }
            elseif ($Script:SNOWAuth.Credentials) {
                Write-Warning "Publish info token not found in response. Proceeding with normal login."
            }
            else {
                Write-Warning "Publish info token not found in response. No credentials provided. Unable to authenticate."
            }
        }
        # First request to get the login page and sysparm_ck token

        # Alternative Login Method
        # Form-Based login is left here for backward compatibility in case the first method fails
        $LoginParams = @{
            Uri        = "https://$Instance.service-now.com/login.do"
            Method     = 'GET'
            WebSession = $WebSession
        }
            
        $LoginResponse = Invoke-WebRequest @LoginParams @ProxyAuth -UseBasicParsing -ErrorAction Stop
        # Extract the security token
        $SecurityToken = $LoginResponse.InputFields | 
        Where-Object { $_.tagName -eq 'INPUT' -and $_.name -eq 'sysparm_ck' } | 
        Select-Object -First 1 -ExpandProperty value
            
        if (!$SecurityToken) {
            Write-Warning "Unable to retrieve sysparm_ck token from login page"
            return $null
        }
            
        $SnowSession.g_ck = $SecurityToken
            
        # Remove any existing authorization headers
        if ($WebSession.Headers['Authorization']) {
            [void]$WebSession.Headers.Remove('Authorization')
        }
            
        # URL encode the password for the login request
        $EncodedPassword = [uri]::EscapeDataString($Credential.GetNetworkCredential().Password)
        # Perform login request
        $AuthParams = @{
            Uri        = "https://$Instance.service-now.com/login.do?user_name=$($Credential.UserName)&user_password=${EncodedPassword}&sys_action=sysverb_login&sysparm_ck=$SecurityToken&sysparm_goto_url=/sys_user_list.do?sysparm_limit=1&sysparm_fields=name,sys_id,user_name"
            Method     = 'GET'
            WebSession = $WebSession
        }
            
        $AuthResponse = Invoke-WebRequest @AuthParams @ProxyAuth -UseBasicParsing
        # Validate login was successful by getting a new security token
        $NewToken = if ($AuthResponse.RawContent -match "(?sm)g_ck\s?=\s?'(?<CkToken>[a-z0-9]+)'") { 
            $Matches.CkToken 
        }
        else {
            Write-Error "g_ck token not found in response. Login  failed." -ErrorAction Stop
            return $null
        }
            
        if ($NewToken) {
            $SnowSession.valid = $true
            $SnowSession.g_ck = $NewToken
            $SnowSession.WebSession = $WebSession
            $SnowSession.Expires = (Get-Date).AddMinutes(45)
            Write-Information "Web session successfully authenticated for $Instance. Updating SNOWAuth session."
            return $SnowSession
        }
        else {
            Write-Warning "Unable to validate session. Please check your credentials and instance name."
            return $null
        }
    }
}
