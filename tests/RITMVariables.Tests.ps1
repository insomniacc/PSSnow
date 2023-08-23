$ModulePath = ($PSScriptRoot | Split-Path -parent) + "\src"
$ProjectName = $PSScriptRoot | Split-Path -parent | Split-Path -leaf
Import-Module "$ModulePath\$ProjectName.psd1" -Force -ErrorAction Stop

InModuleScope $ProjectName {

    BeforeAll {
        $Username = 'DummyUsername'
        $Password = 'DummyPassword'
        $Instance = 'DummyInstance'
        $SSPassword = $Password | ConvertTo-SecureString -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential ($Username, $SSPassword)
        $Script:SNOWAuth = @{
            Instance = $Instance
            Credential = $Credential
            Type = 'basic'
            HandleRatelimiting    = $false
            WebCallTimeoutSeconds = 0
        }

        #Get mock data
        $RITMVariableSetResponse = Import-Clixml "$PSScriptRoot\MockedResponses\Get-SNOWRITMVariableSet.xml"
        $GetRITMResponse = Import-Clixml "$PSScriptRoot\MockedResponses\Get-SNOWRITMVariableSet_Number_GetRITM.xml"
        $SingleRITMVariableResponse = Import-Clixml "$PSScriptRoot\MockedResponses\Set-SNOWRITMVariable_ReturnedVariable.xml"
        

        Mock -CommandName Invoke-SNOWWebRequest -ParameterFilter {$URI -like "*table/sc_req_item*"} -MockWith {
            $GetRITMResponse
        }
        Mock -CommandName Invoke-SNOWWebRequest -ParameterFilter {$URI -like "*table/sc_item_option_mtom*"} -MockWith {
            $RITMVariableSetResponse
        }
        Mock -CommandName Invoke-SNOWWebRequest -ParameterFilter {$URI -like "*table/sc_item_option_mtom*request_item=*^sc_item_option.item_option_new.name*"} -MockWith {
            $SingleRITMVariableResponse
        }
        Mock -CommandName Invoke-SNOWWebRequest -ParameterFilter {$URI -like "*table/sc_item_option*" -and $METHOD -eq "PATCH" -and $UseRestMethod.IsPresent} -MockWith {}    
    }

    Describe "Get-SNOWRITMVariableSet" {
        It "Should return variables [-number]" {
            $Output = Get-SNOWRITMVariableSet -number "RITM0010001"
            $Output | Should -BeOfType PSCustomObject
            ($Output | Get-Member -MemberType NoteProperty).Name | Should -Contain "number"
            ($Output | Get-Member -MemberType NoteProperty).Count | Should -BeGreaterThan 1
            Should -Invoke Invoke-SNOWWebRequest -Exactly 2
        }

        It "Should return variables [-sys_id]" {
            $Output = Get-SNOWRITMVariableSet -Sys_Id "a07e6bd947616110d3e5fa8bd36d4339"
            $Output | Should -BeOfType PSCustomObject
            ($Output | Get-Member -MemberType NoteProperty).Name | Should -Contain "sys_id"
            ($Output | Get-Member -MemberType NoteProperty).Count | Should -BeGreaterThan 1
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1
        }

        It "Should process multiple piped objects" {
            $PipedInput = @(
                [PSCustomObject]@{sys_id = "38cb1cda01654af48b55944a7a81eeef"}
                [PSCustomObject]@{sys_id = "1c14ebfc14c648d380f09f65d09a2f6d"}
                [PSCustomObject]@{sys_id = "895b0ff452624dbb8f4346d94327029f"}
                [PSCustomObject]@{sys_id = "186632a276f04240b809fd7f9df0321c"}
            )
            $Output = $PipedInput | Get-SNOWRITMVariableSet
            $Output.count | Should -Be 4
            Should -Invoke Invoke-SNOWWebRequest -Exactly 4
        }
    }

    Describe "Set-SNOWRITMVariable" {
        It "Should update a RITM Variable [-number]" {
            $Output = Set-SNOWRITMVariable -number "RITM0010001" -Name "business_purpose" -Value "Test"
            Should -Invoke Invoke-SNOWWebRequest -Exactly 2 -ParameterFilter {-not $UseRestMethod.IsPresent}
            Should -Invoke Invoke-SNOWWebRequest -ParameterFilter {$URI -like "*table/sc_item_option*" -and $METHOD -eq "PATCH" -and $UseRestMethod.IsPresent} -Exactly 1
            $Output | Should -BeNullOrEmpty
        }
        It "Should update a RITM Variable [-sys_id]" {
            $Output = Set-SNOWRITMVariable -sys_id "a07e6bd947616110d3e5fa8bd36d4339" -Name "business_purpose" -Value "Test"
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {-not $UseRestMethod.IsPresent}
            Should -Invoke Invoke-SNOWWebRequest -ParameterFilter {$URI -like "*table/sc_item_option*" -and $METHOD -eq "PATCH" -and $UseRestMethod.IsPresent} -Exactly 1
            $Output | Should -BeNullOrEmpty
        }
        It "Should accept a piped RITM" {
            [PSCustomObject]@{sys_id = "38cb1cda01654af48b55944a7a81eeef"} | Set-SNOWRITMVariable -Name "business_purpose" -Value "Test"
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {-not $UseRestMethod.IsPresent}
            Should -Invoke Invoke-SNOWWebRequest -ParameterFilter {$URI -like "*table/sc_item_option*" -and $METHOD -eq "PATCH" -and $UseRestMethod.IsPresent} -Exactly 1
        }
        It "Should accept a piped RITM variable set" {
            Get-SNOWRITMVariableSet -Sys_Id "a07e6bd947616110d3e5fa8bd36d4339" | Set-SNOWRITMVariable -Name "business_purpose" -Value "Test"
            Should -Invoke Invoke-SNOWWebRequest -Exactly 2 -ParameterFilter {-not $UseRestMethod.IsPresent}
            Should -Invoke Invoke-SNOWWebRequest -ParameterFilter {$URI -like "*table/sc_item_option*" -and $METHOD -eq "PATCH" -and $UseRestMethod.IsPresent} -Exactly 1
        }
    }
}