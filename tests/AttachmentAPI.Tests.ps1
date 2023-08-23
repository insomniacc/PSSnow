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
        }



        Mock -CommandName Invoke-SNOWWebRequest -ParameterFilter { 
            $URI -like '*/v1/attachment/*' -and
            $Method -eq "DELETE" -and
            $UseRestMethod.IsPresent
        } -MockWith {}

        #Get mock data
        $NewAttachment = Import-Clixml "$PSScriptRoot\MockedResponses\New-SNOWAttachment.xml"

        Mock -CommandName Invoke-SNOWWebRequest -ParameterFilter { 
            $URI -like '*/attachment/file*' -and
            $URI -notlike "*/file" -and 
            $Method -eq "POST" -and
            $UseRestMethod.IsPresent
        } -MockWith {$NewAttachment}

        #Generic get attachment call
        Mock -CommandName Invoke-SNOWWebRequest -ParameterFilter { 
            $URI -like '*/attachment*' -and
            $URI -notlike "*/file" -and 
            $Method -eq "GET" -and
            $UseRestMethod.IsPresent
        } -MockWith {$AttachmentRestMethod}

        #paged get attachment call
        Mock -CommandName Invoke-SNOWWebRequest -ParameterFilter { 
            $URI -like '*/attachment*' -and
            $Method -eq "GET" -and
            -not $UseRestMethod.IsPresent
        } -MockWith {$AttachmentWebRequest}

        #Download attachment to file
        Mock -CommandName Invoke-SNOWWebRequest -ParameterFilter { 
            $URI -like '*/attachment*' -and
            $URI -like "*/file" -and
            $null -ne $OutFile -and
            $Method -eq "GET" -and
            $UseRestMethod.IsPresent
        } -MockWith {}

        #Return attachment Content
        Mock -CommandName Invoke-SNOWWebRequest -ParameterFilter { 
            $URI -like '*/attachment*' -and
            $URI -like "*/file" -and
            $Method -eq "GET" -and
            $UseRestMethod.IsPresent
        } -MockWith {"Dummy File Content"}
    }

    Describe "Get-SNOWAttachment" {
        BeforeAll {

        }

        BeforeEach {
            #Get mock data
            $AttachmentWebRequest = Import-Clixml "$PSScriptRoot\MockedResponses\Get-SNOWAttachment_WebRequest.xml"
            $AttachmentRestMethod = Import-Clixml "$PSScriptRoot\MockedResponses\Get-SNOWAttachment_RestMethod.xml"
        }

        It "Should directly lookup an attachment record" {
            $Output = Get-SNOWAttachment -Sys_ID "d935469347e16110d3e5fa8bd36d43a8"

            $Output.file_name | Should -Not -BeNullOrEmpty
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*/v1/attachment/d935469347e16110d3e5fa8bd36d43a8" -and
                $UseRestMethod.IsPresent
            }
        }

        It "Should return output from a piped object" {
            $PipedObject = [pscustomobject]@{
                sys_id="d935469347e16110d3e5fa8bd36d43a8"
                sys_class_name="sys_user"
            }
            $Output = $PipedObject | Get-SNOWAttachment

            $Output | Should -Not -BeNullOrEmpty
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment?sysparm_query=table_sys_id=d935469347e16110d3e5fa8bd36d43a8^table_name=sys_user&sysparm_limit=50&sysparm_offset=0" -and
                -not $UseRestMethod.IsPresent
            }
        }

        It "Should return output from a piped object [-limit 51]" {
            $PipedObject = [pscustomobject]@{
                sys_id="d935469347e16110d3e5fa8bd36d43a8"
                sys_class_name="sys_user"
            }
            $Output = $PipedObject | Get-SNOWAttachment -limit 5000

            $Output.file_name | Should -Not -BeNullOrEmpty
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment?sysparm_query=table_sys_id=d935469347e16110d3e5fa8bd36d43a8^table_name=sys_user&sysparm_limit=50&sysparm_offset=0" -and
                $UseRestMethod.IsPresent
            }
        }

        It "Should return output from a piped object [-DisregardSourceTable]" {
            $PipedObject = [pscustomobject]@{
                sys_id="d935469347e16110d3e5fa8bd36d43a8"
                sys_class_name="sys_user"
            }
            $Output = $PipedObject | Get-SNOWAttachment -DisregardSourceTable

            $Output | Should -Not -BeNullOrEmpty
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment?sysparm_query=table_sys_id=d935469347e16110d3e5fa8bd36d43a8&sysparm_limit=50&sysparm_offset=0" -and
                -not $UseRestMethod.IsPresent
            }
        }

        It "Should return output from a query" {
            $Output = Get-SNOWAttachment -Query "file_name=photo" -limit 1

            $Output.file_name | Should -Not -BeNullOrEmpty
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment?sysparm_query=file_name=photo&sysparm_limit=1" -and
                $UseRestMethod.IsPresent
            }
        }

        It "Should contain the attachment with -PassThru" {
            $Output = Get-SNOWAttachment -Sys_ID "d935469347e16110d3e5fa8bd36d43a8" -PassThru
            
            $Output.file_name | Should -Not -BeNullOrEmpty
            $Output.content | Should -BeExactly "Dummy File Content"
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*/v1/attachment/d935469347e16110d3e5fa8bd36d43a8" -and
                $UseRestMethod.IsPresent
            }
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment/d935469347e16110d3e5fa8bd36d43a8/file" -and
                $UseRestMethod.IsPresent
            }
        }

        It "Should download the attachment to file" {
            $Output = Get-SNOWAttachment -Sys_ID "d935469347e16110d3e5fa8bd36d43a8" -OutputDestination "C:\Temp\" -Verbose
            
            $Output.file_name | Should -Not -BeNullOrEmpty
            $Output.output_filepath | Should -Be "C:\Temp\photo"

            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*/v1/attachment/d935469347e16110d3e5fa8bd36d43a8" -and
                $UseRestMethod.IsPresent
            }
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment/d935469347e16110d3e5fa8bd36d43a8/file" -and
                $OutFile -eq "C:\Temp\photo" -and
                $UseRestMethod.IsPresent
            }
        }

        It "Should download the attachment to file with a custom filename" {
            $Output = Get-SNOWAttachment -Sys_ID "d935469347e16110d3e5fa8bd36d43a8" -OutputDestination "C:\Temp\" -OutputFilename "anything.txt" -Verbose
            
            $Output.file_name | Should -Not -BeNullOrEmpty
            $Output.file_name | Should -Not -Be "anything.txt"
            $Output.output_filepath | Should -Be "C:\Temp\anything.txt"

            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*/v1/attachment/d935469347e16110d3e5fa8bd36d43a8" -and
                $UseRestMethod.IsPresent
            }
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment/d935469347e16110d3e5fa8bd36d43a8/file" -and
                $OutFile -eq "C:\Temp\anything.txt" -and
                $UseRestMethod.IsPresent
            }
        }
    }

    Describe "New-SNOWAttachment" {
        BeforeAll {
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
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $Method -eq "POST"
                $URI -like "*v1/attachment/file?file_name=HotPotato.txt&table_name=sys_user&table_sys_id=a52eb6cf47e52110d3e5fa8bd36d432a" -and
                $UseRestMethod.IsPresent
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
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $Method -eq "POST" -and
                $URI -like "*v1/attachment/file?file_name=ColdPotato.docx&table_name=sys_user&table_sys_id=a52eb6cf47e52110d3e5fa8bd36d432a" -and
                $UseRestMethod.IsPresent
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
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $Method -eq "POST" -and
                $URI -like "*v1/attachment/file?file_name=HotPotato.txt&table_name=sys_user&table_sys_id=a52eb6cf47e52110d3e5fa8bd36d432a" -and
                $UseRestMethod.IsPresent
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
            Should -Invoke Invoke-SNOWWebRequest -ParameterFilter {$UseRestMethod.IsPresent} -Exactly 0
        }
    }

    Describe "Remove-SNOWAttachment" {
        It "Should delete an attachment" {
            $Output = Remove-SNOWAttachment -Sys_ID "231018bfc0664604b5b2573578e537f6" -Confirm:$false

            $Output | Should -BeNullOrEmpty
            Should -Invoke Invoke-SNOWWebRequest -Exactly 1 -ParameterFilter {
                $URI -like "*v1/attachment/231018bfc0664604b5b2573578e537f6" -and
                $Method -eq "DELETE" -and
                $UseRestMethod.IsPresent
            }
        }
    }

    Describe "Set-SNOWUserPhoto" {
        BeforeAll {
            $TestFile = "TestDrive:\UglyMug.csv"
            Set-Content $TestFile -value "UglyMug.csv"
            $TestPicture = "TestDrive:\UglyMug.jpg"
            Set-Content $TestPicture -value "UglyMug.jpg"

            Mock Get-SNOWAttachment -MockWith {[PSCustomObject]@{sys_id=$SNOWGUID}}
        }
        BeforeEach {
            $SNOWGUID = (new-guid) -replace "-"
        }

        It "Should reject the wrong filetype" {
            $PhotoSplat = @{
                Filepath = "$TestDrive\UglyMug.csv"
                Sys_ID = $SNOWGUID
            }
            $ShouldSplat = @{
                Throw           = $true
                ExpectedMessage = "Cannot validate argument on parameter 'Filepath'. Incorrect filetype, must be one of the following: .jpg,.png,.bmp,.gif,.jpeg,.ico,.svg"
                ExceptionType   = ([System.Management.Automation.ParameterBindingException])
            }
            {Set-SNOWUserPhoto @PhotoSplat} | Should @ShouldSplat
        }

        It "Should set a new user photo" {
            $PhotoSplat = @{
                Filepath = "$TestDrive\UglyMug.jpg"
                Sys_ID = $SNOWGUID
            }
            Set-SNOWUserPhoto @PhotoSplat

            Should -Invoke Get-SNOWAttachment -Exactly 1

            Should -Invoke Invoke-SNOWWebRequest -ParameterFilter {
                $Method -eq "DELETE" -and
                $UseRestMethod.IsPresent
            } -Exactly 1

            Should -Invoke Invoke-SNOWWebRequest -ParameterFilter {
                $Method -eq "POST" -and
                $UseRestMethod.IsPresent
            } -Exactly 1
        }

        It "Should set a new user photo and return output [-PassThru]" {
            $PhotoSplat = @{
                Filepath = "$TestDrive\UglyMug.jpg"
                Sys_ID = $SNOWGUID
                PassThru = $true
            }
            $output = Set-SNOWUserPhoto @PhotoSplat

            $output | Should -Not -BeNullOrEmpty
            $output | Should -BeOfType PSCustomObject

            Should -Invoke Get-SNOWAttachment -Exactly 1

            Should -Invoke Invoke-SNOWWebRequest -ParameterFilter {
                $Method -eq "DELETE" -and
                $UseRestMethod.IsPresent
            } -Exactly 1

            Should -Invoke Invoke-SNOWWebRequest -ParameterFilter {
                $Method -eq "POST" -and
                $UseRestMethod.IsPresent
            } -Exactly 1
        }

        It "Should return a batch request" {
            $PhotoSplat = @{
                Filepath = "$TestDrive\UglyMug.jpg"
                Sys_ID = $SNOWGUID
                AsBatchRequest = $true
            }
            $output = Set-SNOWUserPhoto @PhotoSplat

            $output | Should -Not -BeNullOrEmpty
            $output | Should -BeOfType Hashtable

            Should -Invoke Get-SNOWAttachment -Exactly 0
            Should -Invoke Invoke-SNOWWebRequest -ParameterFilter {$UseRestMethod.IsPresent} -Exactly 0
        }

    }
}