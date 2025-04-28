$ScriptRoot = $PSScriptRoot
$ModulePath = ($ScriptRoot | Split-Path -Parent) + "\src"
$ProjectName = $ScriptRoot | Split-Path -Parent | Split-Path -Leaf
Import-Module "$ModulePath\$ProjectName.psd1" -Force -ErrorAction Stop

InModuleScope $ProjectName {
    $env:SKIP_MOCKS = 'true'
    Describe "WebSession Tests" -Tag "Unit" {
        BeforeAll {
            . "$PSScriptRoot\Helpers\WebTestHelpers.ps1"
            $RestMethodResponse = Import-Clixml "$PSScriptRoot\MockedResponses\Set-SNOWAuth_oauth.xml"

            $Username = 'DummyUsername'
            $Password = 'DummyPassword'
            $Instance = 'DummyInstance'
            $SSPassword = $Password | ConvertTo-SecureString -AsPlainText -Force
            $Script:Credential = New-Object PSCredential ($Username, $SSPassword)
            $Script:Command = Get-Command Set-SNOWAuth

        }

        
        Context 'New-SNOWAuthWebSession' -Tag "Unit" {
            BeforeAll {
                MockSuccessfulLoginWebRequests
            }

            It "should get a web session during Set-SNOWAuth with UseWebSession." {
                Set-SNOWAuth -Instance $Instance -Credential $Credential -UseWebSession
                $script:SNOWAuth | Should -BeOfType Hashtable
                $script:SNOWAuth.session.g_ck | Should -Not -BeNullOrEmpty
                Should -Invoke Invoke-WebRequest -Exactly 3
            }

            It "Should be able to fetch a web session after authenticating." {
                Set-SNOWAuth -Instance $Instance -Credential $Credential
                $script:SNOWAuth | Should -BeOfType Hashtable
                $script:SNOWAuth.Instance | Should -BeExactly $Instance
                $script:SNOWAuth.Credential | Should -BeExactly $Credential
                $script:SNOWAuth.type | Should -BeExactly 'basic'
                $script:SNOWAuth.session.g_ck | Should -BeNull
                $script:SNOWAuth.session = New-SNOWAuthWebSession -Instance $Instance -Credential $Credential
                $script:SNOWAuth.session.g_ck | Should -Not -BeNullOrEmpty
                Should -Invoke Invoke-WebRequest -Exactly 2
            }
          
            It "Should fail when there are no cookies after authentication" {
                $ValidateSessionNoCookieResponse = Import-Clixml(GetMockFilePath "Invoke-WebRequest-GET-ValidateSessionState-user-Invalid-NoCookies.admin.xml")

                
                Set-SNOWAuth -Instance $Instance -Credential $Credential -UseWebSession
                $script:SNOWAuth.type | Should -BeExactly 'basic'
                $script:SNOWAuth.session.g_ck | Should -Not -BeNullOrEmpty
                # We fake update the cookies.
                $Script:SNOWAuth.session.WebSession.Cookies = [System.Net.CookieContainer]::new()
                Should -Invoke Invoke-WebRequest -Exactly 3
                Mock -CommandName Invoke-WebRequest -ParameterFilter { 
                    $URI -like "*sys_user?sysparm_limit=1&sysparm_fields=sys_id,name,user_name&sysparm_query=user_name=*" -and $Method -eq "GET" `
                        -and $WebSession.Cookies.GetCookies($URI).Count -eq 0 -and $WebSession.Headers['X-UserToken'] -match "[a-z0-9]{60,}"
                } -MockWith { $ValidateSessionNoCookieResponse }
                $SessionState = Get-SNOWWebSessionState -ValidateSession
                $SessionState.Valid | Should -BeFalse
                $SessionState.StatusCode | Should -BeExactly 401
                $SessionState.ValidationMessage | Should -BeLike '*User Not Authenticated*'
            }
        }
        
        Context "Get-SNOWWebSession" -Tag "Unit" {
            Describe 'Valid Login' {
                BeforeAll {
                    MockSuccessfulLoginWebRequests
                }
                It "Should return a valid SessionState object when authenticated with -WebLogin" {
                    Set-SNOWAuth -Instance $Instance -Credential $Credential -UseWebSession
                    $script:SNOWAuth.session.g_ck | Should -Not -BeNullOrEmpty
                    $SessionState = Get-SNOWWebSessionState -ValidateSession
                    $SessionState | Should -BeOfType 'PSCustomObject'
                    $SessionState.Instance | Should -BeExactly $Instance
                    $SessionState.HasSecurityToken | Should -BeTrue
                    $SessionState.Valid | Should -BeTrue
                    $SessionState.ValidationMessage | Should -BeExactly 'Session is valid and authenticated'
                    $SessionState.CookieCount | Should -BeGreaterThan 0
                    $SessionState.CookiesValid | Should -BeTrue
                    $SessionState.CookieString | Should -Not -BeNullOrEmpty
                    $SessionState.SecurityToken | Should -Not -BeNullOrEmpty
                    $SessionState.StatusCode | Should -BeExactly 200
                    $SessionState.User.user_name | Should -BeOfType 'string'
                    $SessionState.User.sys_id | Should -Match '[a-z0-9]{32}'
                }
            }
            Describe 'Invalid Login' {
                It 'Should fail when cookies are expired' {
                    # Simulate expiring cookies withing 1 minute to trigger re-authentication.
                    $env:SKIP_MOCKS = $null
                    MockSuccessfulLoginWebRequests -ExpireCookies
                    
                    Set-SNOWAuth -Instance $Instance -Credential $Credential -UseWebSession
                    $env:SKIP_MOCKS = 'true'
                    $script:SNOWAuth | Should -BeOfType Hashtable
                    $State = $Script:SNOWAuth.SessionState
                    $State.Valid | Should -BeFalse
                    $State.ValidationMessage | Should -BeLike '*Cookies are about to expire within*'
                }

                It 'Should successfully Re-Authenticate during Assert-SNOWAuth when cookies are expired' {
                    # Simulate expiring cookies withing 1 minute to trigger re-authentication.
                    Remove-Item Alias:\Invoke-WebRequest -ErrorAction Ignore
                    MockSuccessfulLoginWebRequests -ExpireCookies
                    Set-SNOWAuth -Instance $Instance -Credential $Credential -UseWebSession
                    $script:SNOWAuth | Should -BeOfType Hashtable
                    $State = $Script:SNOWAuth.SessionState
                    $State.Valid | Should -BeFalse
                    Remove-Item Alias:\Invoke-WebRequest -ErrorAction Ignore
                    MockSuccessfulLoginWebRequests
                    Assert-SNOWAuth
                    $Script:SNOWAuth.SessionState | Should -BeOfType 'PSCustomObject'
                    $Script:SNOWAuth.SessionState.Instance | Should -BeExactly $Instance
                    $Script:SNOWAuth.SessionState.HasSecurityToken | Should -BeTrue
                    $Script:SNOWAuth.SessionState.Valid | Should -BeTrue
                    $Script:SNOWAuth.SessionState.CookiesValid | Should -BeTrue
                    $Script:SNOWAuth.SessionState.CookieString | Should -Not -BeNullOrEmpty
                    $Script:SNOWAuth.SessionState.SecurityToken | Should -Not -BeNullOrEmpty
                }
            }
        }
    }
}