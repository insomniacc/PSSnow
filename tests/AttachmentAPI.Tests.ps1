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
        Set-SNOWAuth -instance $Instance -credential $Credential
    }

    Describe "Get-SNOWAttachment" {
        BeforeAll {
            #Generic get attachment call
            Mock -CommandName Invoke-RestMethod -ParameterFilter { 
                $URI -like '*/attachment*' -and
                $URI -notlike "*/file"
            } -MockWith {$AttachmentRestMethod}

            #paged get attachment call
            Mock -CommandName Invoke-WebRequest -ParameterFilter { 
                $URI -like '*/attachment*'
            } -MockWith {$AttachmentWebRequest}

            #Download attachment to file
            Mock -CommandName Invoke-RestMethod -ParameterFilter { 
                $URI -like '*/attachment*' -and
                $URI -like "*/file" -and
                $null -ne $OutFile
            } -MockWith {}

            #Return attachment Content
            Mock -CommandName Invoke-RestMethod -ParameterFilter { 
                $URI -like '*/attachment*' -and
                $URI -like "*/file"
            } -MockWith {"Dummy File Content"}
        }

        BeforeEach {
            #Get mock data
            $AttachmentWebRequest = Import-Clixml "$PSScriptRoot\MockedResponses\Get-SNOWAttachment_WebRequest.xml"
            $AttachmentRestMethod = Import-Clixml "$PSScriptRoot\MockedResponses\Get-SNOWAttachment_RestMethod.xml"
        }

        It "Should directly lookup an attachment record" {
            $Output = Get-SNOWAttachment -Sys_ID "d935469347e16110d3e5fa8bd36d43a8"

            $Output.file_name | Should -Not -BeNullOrEmpty
            Should -Invoke Invoke-RestMethod -Exactly 1 -ParameterFilter {
                $URI -like "*/v1/attachment/d935469347e16110d3e5fa8bd36d43a8"
            }
        }

        It "Should return output from a piped object" {
            $PipedObject = [pscustomobject]@{
                sys_id="d935469347e16110d3e5fa8bd36d43a8"
                sys_class_name="sys_user"
            }
            $Output = $PipedObject | Get-SNOWAttachment

            $Output | Should -Not -BeNullOrEmpty
            Should -Invoke Invoke-WebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment?sysparm_query=table_sys_id=d935469347e16110d3e5fa8bd36d43a8^table_name=sys_user&sysparm_limit=50&sysparm_offset=0"
            }
        }

        It "Should return output from a piped object [-limit 51]" {
            $PipedObject = [pscustomobject]@{
                sys_id="d935469347e16110d3e5fa8bd36d43a8"
                sys_class_name="sys_user"
            }
            $Output = $PipedObject | Get-SNOWAttachment -limit 5000

            $Output.file_name | Should -Not -BeNullOrEmpty
            Should -Invoke Invoke-RestMethod -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment?sysparm_query=table_sys_id=d935469347e16110d3e5fa8bd36d43a8^table_name=sys_user&sysparm_limit=50&sysparm_offset=0"
            }
        }

        It "Should return output from a piped object [-DisregardSourceTable]" {
            $PipedObject = [pscustomobject]@{
                sys_id="d935469347e16110d3e5fa8bd36d43a8"
                sys_class_name="sys_user"
            }
            $Output = $PipedObject | Get-SNOWAttachment -DisregardSourceTable

            $Output | Should -Not -BeNullOrEmpty
            Should -Invoke Invoke-WebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment?sysparm_query=table_sys_id=d935469347e16110d3e5fa8bd36d43a8&sysparm_limit=50&sysparm_offset=0"
            }
        }

        It "Should return output from a query" {
            $Output = Get-SNOWAttachment -Query "file_name=photo" -limit 1

            $Output.file_name | Should -Not -BeNullOrEmpty
            Should -Invoke Invoke-RestMethod -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment?sysparm_query=file_name=photo&sysparm_limit=1"
            }
        }

        It "Should contain the attachment with -PassThru" {
            $Output = Get-SNOWAttachment -Sys_ID "d935469347e16110d3e5fa8bd36d43a8" -PassThru
            
            $Output.file_name | Should -Not -BeNullOrEmpty
            $Output.content | Should -BeExactly "Dummy File Content"
            Should -Invoke Invoke-RestMethod -Exactly 1 -ParameterFilter {
                $URI -like "*/v1/attachment/d935469347e16110d3e5fa8bd36d43a8"
            }
            Should -Invoke Invoke-RestMethod -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment/d935469347e16110d3e5fa8bd36d43a8/file"
            }
        }

        It "Should download the attachment to file" {
            $Output = Get-SNOWAttachment -Sys_ID "d935469347e16110d3e5fa8bd36d43a8" -OutputDestination "C:\Temp\" -Verbose
            
            $Output.file_name | Should -Not -BeNullOrEmpty
            $Output.output_filepath | Should -Be "C:\Temp\photo"

            Should -Invoke Invoke-RestMethod -Exactly 1 -ParameterFilter {
                $URI -like "*/v1/attachment/d935469347e16110d3e5fa8bd36d43a8"
            }
            Should -Invoke Invoke-RestMethod -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment/d935469347e16110d3e5fa8bd36d43a8/file" -and
                $OutFile -eq "C:\Temp\photo"
            }
        }

        It "Should download the attachment to file with a custom filename" {
            $Output = Get-SNOWAttachment -Sys_ID "d935469347e16110d3e5fa8bd36d43a8" -OutputDestination "C:\Temp\" -OutputFilename "anything.txt" -Verbose
            
            $Output.file_name | Should -Not -BeNullOrEmpty
            $Output.file_name | Should -Not -Be "anything.txt"
            $Output.output_filepath | Should -Be "C:\Temp\anything.txt"

            Should -Invoke Invoke-RestMethod -Exactly 1 -ParameterFilter {
                $URI -like "*/v1/attachment/d935469347e16110d3e5fa8bd36d43a8"
            }
            Should -Invoke Invoke-RestMethod -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment/d935469347e16110d3e5fa8bd36d43a8/file" -and
                $OutFile -eq "C:\Temp\anything.txt"
            }
        }
    }
    Describe "New-SNOWAttachment" {
        BeforeEach {
            #Get mock data
            $AttachmentWebRequest = Import-Clixml "$PSScriptRoot\MockedResponses\Get-SNOWAttachment_WebRequest.xml"
            $AttachmentRestMethod = Import-Clixml "$PSScriptRoot\MockedResponses\Get-SNOWAttachment_RestMethod.xml"

            #Generic get attachment call
            Mock -CommandName Invoke-RestMethod -ParameterFilter { 
                $URI -like '*/attachment*' -and
                $URI -notlike "*/file"
            } -MockWith {$AttachmentRestMethod}
        }

        It "Should create a new attachment" {

        }
    }
    Describe "Set-SNOWAttachment" {}
    Describe "Remove-SNOWAttachment" {}
    Describe "Set-SNOWUserPhoto" {}
}