$ModulePath = ($PSScriptRoot | Split-Path -parent) + "\src"
$ProjectName = $PSScriptRoot | Split-Path -parent | Split-Path -leaf
Import-Module "$ModulePath\$ProjectName.psd1" -Force -ErrorAction Stop

InModuleScope $ProjectName {

    BeforeAll {
        #Get mock data
        $BatchRequestResponse = Import-Clixml "$PSScriptRoot\MockedResponses\Invoke-BatchRequest.xml"
        $RestMethodResponse = Import-Clixml "$PSScriptRoot\MockedResponses\Invoke-RestMethod.xml"

        $Username = 'DummyUsername'
        $Password = 'DummyPassword'
        $Instance = 'DummyInstance'
        $SSPassword = $Password | ConvertTo-SecureString -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential ($Username, $SSPassword)
        $Script:SNOWAuth = @{
            Instance = $Instance
            Credential = $Credential
            Type = 'basic'
        }

        Mock -CommandName Invoke-RestMethod -ParameterFilter { $URI -like '*api/now/v1/batch' } -MockWith {
            $BatchRequestResponse
        }

        Mock -CommandName Invoke-RestMethod -MockWith {
            $RestMethodResponse
        }
    }

    Describe "Invoke-SNOWBatch" {
        It "Should make a single rest call for multiple requests (scriptblock)" {
            $Output = Invoke-SNOWBatch -ScriptBlock {
                Set-SNOWUser -Sys_ID 02826bf03710200044e0bfc8bcbe5d3f -Properties @{middle_name="thomas"}
                Set-SNOWUser -Sys_ID 02826bf03710200044e0bfc8bcbe5d3f -Properties @{middle_name="thomas"}
                Set-SNOWUser -Sys_ID 02826bf03710200044e0bfc8bcbe5d3f -Properties @{middle_name="thomas"}
            }
            $Output | Should -Not -BeNullOrEmpty
            $Output.serviced_requests.count | Should -BeExactly 3
            Should -Invoke Invoke-RestMethod -Exactly 1
        }

        It "Should not throw or provide output when run with no requests" {
            $Output = Invoke-SNOWBatch -ScriptBlock {
                Get-SNOWUser -Sys_ID "02826bf03710200044e0bfc8bcbe5d3f"
            } -WarningAction SilentlyContinue
            $Output | Should -BeNullOrEmpty
            Should -Invoke Invoke-RestMethod -Exactly 0
        }
       
    }

}