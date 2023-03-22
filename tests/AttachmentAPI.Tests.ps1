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
        BeforeAll {
            #Get mock data
            $NewAttachment = Import-Clixml "$PSScriptRoot\MockedResponses\New-SNOWAttachment.xml"

            Mock -CommandName Invoke-RestMethod -ParameterFilter { 
                $Method -eq "POST" -and
                $URI -like '*/attachment/file*' -and
                $URI -notlike "*/file"
            } -MockWith {$NewAttachment}

            $TestFile = "TestDrive:\HotPotato.txt"
            Set-Content $TestFile -value "BakedPotato"
        }

        It "Should throw when file is not found" {
            $AttachmentSplat = @{
                Sys_ID = "a52eb6cf47e52110d3e5fa8bd36d432a"
                Sys_Class_Name = "sys_user"
                File = "$TestDrive\NoPotato.txt"
            }
            $ShouldSplat = @{
                Throw           = $true
                ExpectedMessage = "Cannot validate argument on parameter 'File'. Unable to find file."
                ExceptionType   = ([System.Management.Automation.ParameterBindingException])
            }

            {New-SNOWAttachment @AttachmentSplat} | Should @ShouldSplat
        }

        It "Should create an attachment" {
            $AttachmentSplat = @{
                Sys_ID = "a52eb6cf47e52110d3e5fa8bd36d432a"
                Sys_Class_Name = "sys_user"
                File = "$TestDrive\HotPotato.txt"
            }
            $Output = New-SNOWAttachment @AttachmentSplat

            $Output | Should -BeNullOrEmpty
            Should -Invoke Invoke-RestMethod -Exactly 1 -ParameterFilter {
                $Method -eq "POST"
                $URI -like "*v1/attachment/file?file_name=HotPotato.txt&table_name=sys_user&table_sys_id=a52eb6cf47e52110d3e5fa8bd36d432a"
            }
        }

        It "Should create an attachment with an alternative filename" {
            $AttachmentSplat = @{
                Sys_ID = "a52eb6cf47e52110d3e5fa8bd36d432a"
                Sys_Class_Name = "sys_user"
                File = "$TestDrive\HotPotato.txt"
                AttachedFilename = "ColdPotato.docx"
            }
            $Output = New-SNOWAttachment @AttachmentSplat

            $Output | Should -BeNullOrEmpty
            Should -Invoke Invoke-RestMethod -Exactly 1 -ParameterFilter {
                $Method -eq "POST"
                $URI -like "*v1/attachment/file?file_name=ColdPotato.docx&table_name=sys_user&table_sys_id=a52eb6cf47e52110d3e5fa8bd36d432a"
            }
        }

        It "Should create an attachment and return output [-PassThru]" {
            $AttachmentSplat = @{
                Sys_ID = "a52eb6cf47e52110d3e5fa8bd36d432a"
                Sys_Class_Name = "sys_user"
                File = "$TestDrive\HotPotato.txt"
                PassThru = $true
            }
            $Output = New-SNOWAttachment @AttachmentSplat
            
            $Output | Should -Not -BeNullOrEmpty
            $Output | Should -BeOfType PsCustomObject
            Should -Invoke Invoke-RestMethod -Exactly 1 -ParameterFilter {
                $Method -eq "POST"
                $URI -like "*v1/attachment/file?file_name=HotPotato.txt&table_name=sys_user&table_sys_id=a52eb6cf47e52110d3e5fa8bd36d432a"
            }
        }

        It "Should return a batch request" {
            $AttachmentSplat = @{
                Sys_ID = "a52eb6cf47e52110d3e5fa8bd36d432a"
                Sys_Class_Name = "sys_user"
                File = "$TestDrive\HotPotato.txt"
                AsBatchRequest = $true
            }
            $Output = New-SNOWAttachment @AttachmentSplat

            $Output | Should -Not -BeNullOrEmpty
            $Output | Should -BeOfType Hashtable
            Should -Invoke Invoke-RestMethod -Exactly 0
        }
    }
    Describe "Set-SNOWAttachment" {}
    Describe "Remove-SNOWAttachment" {}
    Describe "Set-SNOWUserPhoto" {}
}