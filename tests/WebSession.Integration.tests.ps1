# PSScriptAnalyzer - TEST Secrets should be transient. Ignore this rule for the tests.
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
param()
$ScriptRoot = $PSScriptRoot
$ModulePath = ($ScriptRoot | Split-Path -Parent) + '\src'
$ProjectName = $ScriptRoot | Split-Path -Parent | Split-Path -Leaf
Import-Module "$ModulePath\$ProjectName.psm1" -Force

InModuleScope $ProjectName {
    Describe 'WebSession Authentication Test' -Skip:(
        ([string]::IsNullOrEmpty($env:SN_TEST_INSTANCE)) -or
        ([string]::IsNullOrEmpty($env:SN_TEST_USERNAME)) -or
        ([string]::IsNullOrEmpty($env:SN_TEST_PASSWORD))
    ) {
        BeforeAll {
            . "$PSScriptRoot\Helpers\WebTestHelpers.ps1"
            Write-Host "Running WebSession Authentication Integration tests against instance: $env:SN_TEST_INSTANCE"
            AssertTestSnowAuth
        }
        BeforeEach {
            $env:SNOW_MOCK_TAG = $null
        }

        Context 'Set-SNOWAuth' -Tag 'Integration' {
            BeforeEach {
                $env:SNOW_MOCK_TAG = $null
            }
            It 'Should set authentication in script scope [basic] with -UseWebSession' {
                $env:SNOW_MOCK_TAG = 'WebLogin'
                $env:SKIP_MOCKS = $null
                Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $Script:TEST_SN_CREDENTIALS -UseWebSession
                $script:SNOWAuth | Should -BeOfType Hashtable
                $script:SNOWAuth.Instance | Should -BeExactly $Script:TEST_SN_INSTANCE
                $script:SNOWAuth.Credential | Should -BeExactly $Script:TEST_SN_CREDENTIALS
                $script:SNOWAuth.type | Should -BeExactly 'basic'
                $script:SNOWAuth.session | Should -BeOfType Hashtable
            }

            
            It 'Should get the Concourse State' {
                $env:SNOW_MOCK_TAG = 'WebLogin'
                Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $Script:TEST_SN_CREDENTIALS -UseWebSession
                $env:SNOW_MOCK_TAG = 'Get-SNOWWebConcourseState'
                $ConcourseState = Get-SNOWWebConcourseState
                $ConcourseState | Should -BeOfType 'PSCustomObject'
                $ConcourseState.Current | Should -Not -BeNullOrEmpty
            }

            #TODO: Should we actually allow this? 
            It 'Should fall back to basic authentication when -UseWebSession fails. e.g. Non-Interactive context' {
                $BadCredential = New-Object PSCredential ('badusername', ('badpassword' | ConvertTo-SecureString -AsPlainText -Force))
                Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $BadCredential -UseWebSession
                $script:SNOWAuth | Should -BeOfType Hashtable
                $script:SNOWAuth.Instance | Should -BeExactly $TEST_SN_INSTANCE
                $script:SNOWAuth.Credential | Should -BeExactly $BadCredential
                $script:SNOWAuth.type | Should -BeExactly 'basic'
                $Script:SNOWAuth.SessionState.Valid | Should -Be $false
            }

            It 'should automatically fall back to basic authentication when the WebSession is invalid' {
                Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $Script:TEST_SN_CREDENTIALS -UseWebSession
                $script:SNOWAuth | Should -BeOfType Hashtable
                $script:SNOWAuth.Instance | Should -BeExactly $Script:TEST_SN_INSTANCE
                $script:SNOWAuth.type | Should -BeExactly 'basic'
                $script:SNOWAuth.session | Should -BeOfType Hashtable
                ## Session is valid up to this point
                $BadSessionState = Import-Clixml "$PSScriptRoot\MockedResponses\Web\Get-SNOWWebSessionState_InvalidCookies.xml"
                Mock -CommandName Get-SNOWWebSessionState -MockWith { $BadSessionState }
                ## Something happened to the session - mocking a bad session.
                $User = Get-SNOWUser -user_name $Script:TEST_SN_CREDENTIALS.UserName
                $User | Should -BeOfType 'PSCustomObject'
                $User.user_name | Should -BeExactly $Script:TEST_SN_CREDENTIALS.UserName
                Assert-MockCalled Get-SNOWWebSessionState -Times 2 -Exactly
                Remove-Item -Path Alias:Get-SNOWWebSessionState -Force
            }   
        }
        Context 'Get-SNOWWebSessionState' -Tag 'Unit' {
            It 'Should return a valid session object' {
                Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $Script:TEST_SN_CREDENTIALS -UseWebSession
                $SessionDetails = Get-SNOWWebSessionState -ValidateSession
                $SessionDetails | Should -BeOfType 'PSCustomObject'
                $SessionDetails.HasSecurityToken | Should -BeTrue
                $SessionDetails.CookieCount | Should -BeGreaterThan 0
            }

            It 'should return invalid when there are no cookies in the session' {
                Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $Script:TEST_SN_CREDENTIALS -UseWebSession
                $script:SNOWAuth.session.g_ck = 'NoCookies'
                $env:SNOW_MOCK_TAG = 'NoCookies'
                $env:SKIP_MOCKS = $null
                $Cont = [System.Net.CookieContainer]::new()
                $Script:SNOWAuth.session.WebSession.Cookies = $Cont
                $SessionDetails = Get-SNOWWebSessionState -ValidateSession
                $SessionDetails | Should -BeOfType 'PSCustomObject'
                $SessionDetails.HasSecurityToken | Should -BeTrue
                $SessionDetails.Valid | Should -BeFalse
            }

            It 'Should return get the UI concourse without WebLogin' {
                Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $Script:TEST_SN_CREDENTIALS
                $ConcourseURI = "/api/now/ui/concoursepicker/current"
                $Result = Invoke-SNOWRestMethod -Uri $ConcourseURI -Method GET
                $Result | Should -BeOfType 'PSCustomObject'
            }
        }

        Context 'Concourse State Functions' -Tag 'Integration' {
            BeforeAll {
                Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $Script:TEST_SN_CREDENTIALS -UseWebSession
            }
            It 'Should get the current concourse state' {
                $SessionDetails = Get-SNOWWebSessionState -ValidateSession
                $SessionDetails | Should -BeOfType 'PSCustomObject'
                $SessionDetails.Instance | Should -BeExactly $Script:TEST_SN_INSTANCE
                $SessionDetails.HasSecurityToken | Should -BeTrue
                $SessionDetails.HasSecurityToken | Should -BeTrue
                $ConcourseState = Get-SNOWWebConcourseState
                $ConcourseState | Should -BeOfType 'PSCustomObject'
                $ConcourseState.Current | Should -Not -BeNullOrEmpty
                $ConcourseState.ConcourseList.availableApplications | Should -Not -BeNullOrEmpty
                $ConcourseState.ConcourseList.availableUpdateSets | Should -Not -BeNullOrEmpty
            }
            It 'Should change the current application to sn_incident_atf' {
                $SessionDetails = Get-SNOWWebSessionState -ValidateSession
                $SessionDetails | Should -BeOfType 'PSCustomObject'
                $SessionDetails.Instance | Should -BeExactly $Script:TEST_SN_INSTANCE
                $SessionDetails.HasSecurityToken | Should -BeTrue
                $TestApp = 'sn_incident_atf'
                $ConcourseState = Get-SNOWWebConcourseState
                $ConcourseState.ConcourseList.availableApplications.scopeName | Should -Contain $TestApp
                $SetResult = Set-SNOWWebConcourseState -ScopeName $TestApp
                $SetResult | Should -BeOfType 'PSCustomObject'
                $SetResult.Current.currentApplication.scopeName | Should -BeExactly $TestApp
            }

            It 'Should change the current application to global' {
                $GSetResult = Set-SNOWWebConcourseState -ScopeName 'global'
                $GSetResult | Should -BeOfType 'PSCustomObject'
                $GSetResult.Current.currentApplication.sysId | Should -Not -BeNullOrEmpty
                $GSetResult.Current.currentApplication.scopeName | Should -BeExactly 'global'
            }
        }

        Context 'Get-SNOWObject with Session' -Tag 'Integration' {
            It 'Should return a valid response' {
                Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $Script:TEST_SN_CREDENTIALS -UseWebSession
                $Response = Get-SNOWObject -Table sys_user -Query 'user_name=admin'
                $Response[0] | Should -BeOfType 'PSCustomObject'
                $Response[0].user_name | Should -BeExactly 'admin'
            }
        }

        Context 'Invoke-SNOWBatch' -Tag 'Integration' {
            It 'Should invoke a batch request successfully when using -UseWebSession' {
                Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $Script:TEST_SN_CREDENTIALS -UseWebSession
                $Users = Get-SNOWUser -user_name $TEST_SN_CREDENTIALS.UserName
                $BatchResponse = Invoke-SNOWBatch -ScriptBlock {
                    foreach ($User in $Users) {
                        $User | Set-SNOWUser -employee_number '12345'
                    }
                } -Parallel
                $BatchResponse | Should -BeOfType 'PSCustomObject'
                $BatchResponse.serviced_requests.body.result.employee_number | Should -BeExactly '12345'
            }
        }
    }
                    
}