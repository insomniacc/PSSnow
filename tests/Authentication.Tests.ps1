$ScriptRoot = $PSScriptRoot
$ModulePath = ($ScriptRoot | Split-Path -parent) + "\src"
$ProjectName = $ScriptRoot | Split-Path -parent | Split-Path -leaf
Import-Module "$ModulePath\$ProjectName.psd1" -Force -ErrorAction Stop

InModuleScope $ProjectName {
    Describe "Authentication" {
        BeforeAll {
            $RestMethodResponse = Import-Clixml "$PSScriptRoot\MockedResponses\Set-SNOWAuth_oauth.xml"

            $Username = 'DummyUsername'
            $Password = 'DummyPassword'
            $Instance = 'DummyInstance'
            $ClientID = "DummyClientID"
            $ClientSecret = "DummyClientSecret" | ConvertTo-SecureString -AsPlainText -Force
            $SSPassword = $Password | ConvertTo-SecureString -AsPlainText -Force
            $Credential = New-Object PSCredential ($Username, $SSPassword)
            $Command = Get-Command Set-SNOWAuth

            Mock -CommandName Invoke-RestMethod -ParameterFilter { $URI -like "*oauth_token*" -and $Method -eq "POST" } -MockWith { $RestMethodResponse }
            Mock -CommandName Invoke-WebRequest -ParameterFilter { $Uri -eq "https://$Instance.service-now.com/stats.do" }
        }

        Context "Set-SNOWAuth" -tag "Unit" {
            It "Should have parameter '<Parameter>' for <RequiredFor>" -ForEach @(
                @{ Parameter = "Instance"; RequiredFor = 'all rest calls'}
                @{ Parameter = "Credential"; RequiredFor = 'basic authentication'}
                @{ Parameter = "ClientID"; RequiredFor = 'oauth authentication'}
                @{ Parameter = "ClientSecret"; RequiredFor = 'oauth authentication'}
            ) {
                $Command.Parameters.Keys | Should -Contain $parameter -Because "$parameter is required for $RequiredFor"
            }

            It "Should set authentication in script scope [basic]" {
                Set-SNOWAuth -instance $Instance -credential $Credential

                $script:SNOWAuth | Should -BeOfType Hashtable
                $script:SNOWAuth.Instance | Should -BeExactly $Instance
                $script:SNOWAuth.Credential | Should -BeExactly $Credential
                $script:SNOWAuth.type | Should -BeExactly 'basic'
                Should -Invoke Invoke-RestMethod -Exactly 0
            }

            It "Should set authentication in script scope [oauth]" {
                Set-SNOWAuth -Instance $Instance -Credential $Credential -ClientId $ClientID -ClientSecret $ClientSecret

                $script:SNOWAuth | Should -BeOfType Hashtable
                $script:SNOWAuth.Instance | Should -BeExactly $Instance
                $script:SNOWAuth.ClientID | Should -BeExactly $ClientID
                $script:SNOWAuth.ClientSecret | Should -BeOfType SecureString
                $script:SNOWAuth.Token | Should -Not -BeNullOrEmpty
                $script:SNOWAuth.Expires | Should -BeOfType DateTime
                $script:SNOWAuth.type | Should -BeExactly 'oauth'
                Should -Invoke Invoke-RestMethod -Exactly 1
            }

            It "Should renew the token on expiry [oauth]" {
                Set-SNOWAuth -Instance $Instance -Credential $Credential -ClientId $ClientID -ClientSecret $ClientSecret
                Assert-SNOWAuth
                $OriginalExpiry = $script:SNOWAuth.Expires
                $ForcedExpiry = (get-date).AddMinutes(-5)
                $script:SNOWAuth.Expires = $ForcedExpiry
                Assert-SNOWAuth

                $script:SNOWAuth.Expires | Should -BeOfType DateTime
                $script:SNOWAuth.Expires | Should -BeGreaterThan $OriginalExpiry
                $script:SNOWAuth.Expires | Should -BeGreaterThan $ForcedExpiry
                Should -Invoke Invoke-RestMethod -Exactly 2
            }

            It "Should throw an exception if the instance is hibernating" {
                Mock -CommandName Invoke-WebRequest -ParameterFilter { $Uri -like "https://$Instance.service-now.com/stats.do"} -MockWith {@{content="Instance Hibernating page"}}
                { Set-SNOWAuth -Instance $Instance -Credential $Credential } | Should -Throw -ExpectedMessage "This servicenow instance is hibernating. Please wake the instance up and use * again."
            }
        }
    }
}