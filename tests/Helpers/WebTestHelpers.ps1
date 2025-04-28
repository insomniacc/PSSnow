# This helper MUST be called in the BeforeAll block of a pester test.
$Script:TestMessage = @"
SNOW Integration Tests.
Required environment variables:
- SN_TEST_INSTANCE (e.g. dev195226)
- SN_TEST_USERNAME (e.g. admin)
- SN_TEST_PASSWORD (e.g. password)
- SN_TEST_VAULT (e.g. 123456)
"@
$Script:PSDefaultParameterValues['Set-SNOWAuth:ProxyUri'] = 'http://localhost:8022'
function AssertTestSnowAuth([switch]$SetAuth) {
    if (-not $env:SN_TEST_INSTANCE) {
        Write-Verbose "The environment variable SN_TEST_INSTANCE is not set. Please set it to the instance you want to test against."
        $Global:SN_TEST_ENABLED = $false
        return
    }
    $Script:IntegrationTestsEnabled = $true
    $Script:TEST_SN_CREDENTIALS = [System.Management.Automation.PSCredential]::new(
        $env:SN_TEST_USERNAME,
        (ConvertTo-SecureString -String $env:SN_TEST_PASSWORD -AsPlainText -Force)
    )
    if($env:SN_TEST_INSTANCE -notlike '*dev*' -and $env:SN_TEST_INSTANCE -notlike '*test*') {
        Write-Error "The `$env:SN_TEST_INSTANCE [$($env:SN_TEST_INSTANCE)] is not a dev or test instance. Please set it to a dev or test instance."
        $Global:SN_TEST_ENABLED = $false
        return
    }
    $Script:TEST_SN_INSTANCE = $env:SN_TEST_INSTANCE
    if($SetAuth){
        Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $Script:TEST_SN_CREDENTIALS -UseWebSession
    }
    $Global:SN_TEST_ENABLED = $true
}

# Mocking Code
# We mock using actual Invoke-WebRequest response object to simulate the real response.
# This gives a better simulation of the actual session handling.


function GetMockFilePath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$FileName
    )
    $MockFilePath = Join-Path -Path $PSScriptRoot -ChildPath "..\MockedResponses\Web\$FileName"
    if (Test-Path $MockFilePath) {
        return $MockFilePath
    }
    else {
        throw "Mock file not found: $MockFilePath"
    }
}


$LoginResponse1 = Import-Clixml (GetMockFilePath "Invoke-WebRequest-GET-sn_devstudio_get_publish_info-WebLogin.admin.xml")
$ValidateSessionStateResponse = Import-Clixml (GetMockFilePath "Invoke-WebRequest-GET-ValidateSessionState-user-Valid-WebLogin.admin.xml")
$GetSnowConcourseCurrentResponse = Import-Clixml (GetMockFilePath "Invoke-RestMethod-GET--api-now-ui-concoursepicker-current-Get-SNOWWebConcourseState.admin.xml")
$GetSnowConcourseListResponse = Import-Clixml (GetMockFilePath "Invoke-RestMethod-GET--api-now-ui-concoursepicker-concourselist-Get-SNOWWebConcourseState.admin.xml")
            

function MockWithCookies($ResponseObject, $WebSession, [string[]]$CookiesToExpire) {
    # JSESSIONID=8B5D8CA710D4149EDF947D6D2CF5AAB3; Path=/; HttpOnly; SameSite=None; Secure,glide_user=; Max-Age=0; Expires=Thu, 01-Jan-1970 00:00:10 GMT; Path=/; Secure; HttpOnly; SameSite=None; Secure,glide_user_session=; Max-Age=0; Expires=Thu, 01-Jan-1970 00:00:10 GMT; Path=/; Secure; HttpOnly; SameSite=None; Secure,glide_user_route=glide.b991c84b46f6f7c27bf249cf57b425cd; Max-Age=2147483647; Expires=Sun, 03-May-2093 18:11:46 GMT; Path=/; Secure; HttpOnly; SameSite=None; Secure,glide_node_id_for_js=9f4f7b490cb0168f1bf91f37a6f3b82c941d35bc53182f09f7afdc2f9a6f5084; Path=/; Secure; SameSite=None; Secure,BIGipServerpool_dev195226=545365514.41278.0000; path=/; Httponly; Secure; SameSite=None; Secure
    
    # Use the new function to parse cookies
    $cookies = ParseCookieHeader -ResponseObject $ResponseObject

    foreach ($cookie in $cookies) {
        $newCookie = New-Object System.Net.Cookie
        $newCookie.Name = $cookie.Name
        $newCookie.Value = $cookie.Value
        $newCookie.Path = $cookie.Path
        $newCookie.Domain = "DummyInstance.service-now.com"
        # Update expiry if the cookie has an expiration and it's already expired. 
        # This could be simplified to unexpire all cookies, but we want to keep the original expiry date.
        # In general, only glide_user_session and glide_session_store are known to expire. (4/10/2025)
        if ($cookie.Expires) {
            $expiryDate = [datetime]::Parse($cookie.Expires)
            if ($expiryDate -lt (Get-Date) -and $expiryDate -gt [datetime]'1970-01-02T00:00:00Z') {
                $newCookie.Expires = (Get-Date).AddHours(1) # Extend expiry by 1 hour
            }
            else {
                $newCookie.Expires = $expiryDate
            }
        }
        if ($CookiesToExpire -contains $newCookie.Name -and (!$Script:LoginCookiesExpired)) {
            Write-Verbose "MockWithCookies Expiring cookie: $($newCookie.Name)"
            $newCookie.Expires = (Get-Date).AddSeconds(30) # Expire the cookie in 30 seconds
        }

        $WebSession.Cookies.Add($newCookie)
    }
    $ResponseObject
}
function MockSuccessfulLoginWebRequests([switch]$ExpireCookies) {
    Mock -CommandName Invoke-WebRequest -ParameterFilter { $Uri -eq "https://$Instance.service-now.com/stats.do" }
    $Script:LoginCookiesExpired = $false
    $Script:ExtraParams = if ($ExpireCookies) {
        @{ CookiesToExpire = @('glide_session_store', 'JSESSIONID') }
    }
    else {
        @{ CookiesToExpire = @() }
    }
    Mock -CommandName Invoke-WebRequest -ParameterFilter { $URI -like "*get_publish_info" -and $Method -eq "GET" } -MockWith { 
        param($URI, $WebSession)
        MockWithCookies -ResponseObject $LoginResponse1 -WebSession $WebSession @ExtraParams
    }
    Mock -CommandName Invoke-WebRequest -ParameterFilter { 
        $URI -like "*sys_user?sysparm_limit=1&sysparm_fields=sys_id,name,user_name&sysparm_query=user_name=*" -and $Method -eq "GET" -and
        $WebSession.Headers['X-UserToken'] -match "[a-z0-9]{60,}"
    } -MockWith { 
        param($URI, $WebSession)
        MockWithCookies -ResponseObject $ValidateSessionStateResponse -WebSession $WebSession @ExtraParams
    }
    
}

function MockGetConcourseListWebRequests() {
    Mock -CommandName Invoke-WebRequest -ParameterFilter { 
        $URI -like "*api/now/ui/concoursepicker/current" -and $Method -eq "GET" -and
        $Headers['X-UserToken'] -match "[a-z0-9]{60,}"
        
    } -MockWith { $GetSnowConcourseCurrentResponse } 
    Mock -CommandName Invoke-WebRequest -ParameterFilter { 
        $URI -like "*api/now/ui/concoursepicker/concourselist*" -and $Method -eq "GET" -and
        $Headers['X-UserToken'] -match "[a-z0-9]{60,}"
    } -MockWith { $GetSnowConcourseListResponse } 
}


function ParseCookieHeader {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [object]$ResponseObject
    )

    begin {
        function ConvertTo-EpochTimestamp {
            param([string]$dateStr)
            try {
                $dt = [datetime]::ParseExact($dateStr, 'ddd, dd-MMM-yyyy HH:mm:ss GMT', $null)
                $epoch = [long]($dt.ToUniversalTime() - [datetime]'1970-01-01').TotalSeconds
                return $epoch
            }
            catch {
                return $dateStr
            }
        }
    }

    process {
        $setCookieHeader = $ResponseObject.Headers['Set-Cookie']
        
        if ($null -eq $setCookieHeader) {
            Write-Verbose "No Set-Cookie header found in the response"
            return @()
        }

        if ($setCookieHeader.Count -eq 1) {
            $setCookieHeader = [regex]::Replace($setCookieHeader, 'Expires=([^;]+GMT)', {
                    $dateStr = $args[0].Groups[1].Value
                    return "Expires=$(ConvertTo-EpochTimestamp $dateStr)"
                })
            $cookies = $setCookieHeader -split ',\s*'
        }
        elseif ($setCookieHeader.Count -gt 1) {
            $cookies = foreach ($header in $setCookieHeader) {
                [regex]::Replace($header, 'Expires=([^;]+GMT)', {
                        $dateStr = $args[0].Groups[1].Value
                        return "Expires=$(ConvertTo-EpochTimestamp $dateStr)"
                    })
            }
        }
        else {
            $cookies = @()
        }
        $OutCookies = foreach ($cookie in $cookies) {
            $cookieParts = $cookie -split '[;],', 2
            $nameValue = $cookieParts[0] -split '=', 2
            $newCookie = [ordered]@{}
            $newCookie.Name = $nameValue[0].Trim()
            $newCookie.Value = $nameValue[1] -split ';', 2 | Select-Object -First 1
            $newCookie.Path = "/"
            if ($cookie -match 'Expires=([^;]+)') {
                $newCookie.Expires = [DateTimeOffset]::FromUnixTimeSeconds([long]$matches['expiry']).DateTime
            }
            $newCookie
        }

        return $OutCookies
    }
}
