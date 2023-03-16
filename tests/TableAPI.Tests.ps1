$global:ScriptRoot = $PSScriptRoot
$ProjectName = $global:ScriptRoot | Split-Path -parent | Split-Path -leaf
$global:ModulePath = ($global:ScriptRoot | Split-Path -parent) + "\src"

Import-Module "$global:ModulePath\$ProjectName.psd1" -Force -ErrorAction Stop

InModuleScope "PSServicenow" {
    
    BeforeDiscovery {
        $TableCommands = (Get-ChildItem "$global:ModulePath\Public\table\*" -include "*.ps1").BaseName | ? {$_ -NotLike "*-SNOWObject"}

        $TemplateCommands = @(
            @{
                CommandName = "Get-SNOWObject"
                ExpectedParameters = @('DisplayValue','ExcludeReferenceLinks','Fields','Limit','Offset','Query','RestrictDomain','Sys_ID','SysParmView','Table')
                Arguments = '-limit 1'
                ExpectsOutput = $true
            }
            @{
                CommandName = "Set-SNOWObject"
                ExpectedParameters = @('AsBatchRequest','InputDisplayValue','PassThru','Properties','Sys_ID','Table')
                Arguments = '-sys_id 02826bf03710200044e0bfc8bcbe5d3f -properties @{"key"="value"} -PassThru'
                ExpectsOutput = $true
            }
            @{
                CommandName = "New-SNOWObject"
                ExpectedParameters = @('AsBatchRequest','InputDisplayValue','PassThru','Properties','Table')
                Arguments = '-properties @{"key"="value"} -PassThru'
                ExpectsOutput = $true
            }
            @{
                CommandName = "Remove-SNOWObject"
                ExpectedParameters = @('RestrictDomain','sys_class_name','Sys_ID','Table')
                Arguments = '-sys_id 02826bf03710200044e0bfc8bcbe5d3f -confirm:$false'
                ExpectsOutput = $false
            }
        )
    }

    BeforeAll {
        #Get mock data
        $WebRequestResponsePaged = Import-Clixml "$global:ScriptRoot\MockedResponses\Invoke-WebRequest_Paged.xml"
        $WebRequestResponseNotPaged = Import-Clixml "$global:ScriptRoot\MockedResponses\Invoke-WebRequest_NotPaged.xml"
        $RestMethodResponse = Import-Clixml "$global:ScriptRoot\MockedResponses\Invoke-RestMethod.xml"

        $Username = 'DummyUsername'
        $Password = 'DummyPassword'
        $Instance = 'DummyInstance'
        $SSPassword = $Password | ConvertTo-SecureString -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential ($Username, $SSPassword)
        Set-SNOWAuth -instance $Instance -credential $Credential
    }

    Describe "Invoke-SNOWTableREAD" {
        BeforeAll {
            Mock -CommandName Invoke-RestMethod -MockWith { 
                for( $i=0; $i -lt 20; $i++){
                    $RestMethodResponse
                } 
            }

            Mock -CommandName Invoke-WebRequest -MockWith {
                $WebRequestResponsePaged
            }

            Mock -CommandName Invoke-WebRequest -ParameterFilter { $URI -like '*sysparm_offset=95' } -MockWith {
                $WebRequestResponseNotPaged
            }
        }

        It "Should paginate, trim, and return an exact number of records (While using limit)" {
            $Output = Invoke-SNOWTableREAD -Parameters @{Limit = 101} -Table "sys_user" -PaginationAmount 20
            $Output.count | Should -BeExactly 101
            Should -Invoke Invoke-RestMethod -Exactly 6
        }

        It "Should return all records (While omitting limit)" {
            $Output = Invoke-SNOWTableREAD -Parameters @{} -Table "sys_user" -PaginationAmount 5
            $Output.count | Should -BeExactly 100
            Should -Invoke Invoke-WebRequest -Exactly 20          
        }
    }

    Describe "<CommandName>" -ForEach $TemplateCommands {
        BeforeAll {
            Mock -CommandName Invoke-WebRequest -ParameterFilter { $Method -in 'GET','PATCH','POST' } -MockWith { $WebRequestResponse }
            Mock -CommandName Invoke-RestMethod -ParameterFilter { $Method -in 'GET','PATCH','POST' } -MockWith { $RestMethodResponse }
            Mock -CommandName Invoke-WebRequest -ParameterFilter { $Method -eq 'DELETE' } -MockWith { }
            Mock -CommandName Invoke-RestMethod -ParameterFilter { $Method -eq 'DELETE' } -MockWith { }
        }

        BeforeEach {
            $Command = Get-Command $CommandName
        }

        It "Should have parameter <_>" -ForEach $ExpectedParameters {
            $_ | Should -BeIn $Command.Parameters.Keys
        }

        It "Should be an advanced function" {
            $Command.CmdletBinding | Should -Be $True
        }

        It "Should return output" -skip:($ExpectsOutput -eq $false) {
            $Scriptblock = [Scriptblock]::Create("$CommandName -table 'sys_user' $Arguments")
            $Output = $Scriptblock.Invoke() 
            $Output | Should -Not -BeNullOrEmpty
            $Output | Should -BeOfType PSCustomObject
            ($Output | Get-member -MemberType NoteProperty).Name | Should -Contain 'sys_id'
        }
    }
    
    
    Describe "Function <_>" -ForEach $TableCommands.Where({$_ -like "Get-*"}) {
        BeforeAll {
            $CommandName = $_
            $Command = Get-Command -Name $CommandName

            Mock -CommandName Invoke-RestMethod -ParameterFilter { $Method -eq 'GET' } -MockWith { $RestMethodResponse }
        }

        It "Should inherit parameters from Get-SNOWObject" {
            $command.Definition | Should -BeLike "*DynamicParam*{*Import-DefaultParamSet*-TemplateFunction*Get-SNOWObject*}*"
        }

        It "Should use Invoke-SNOWTableREAD" {
            $command.Definition | Should -BeLike "*Invoke-SNOWTableREAD*"
        }

        It "Should return output with -limit 1" {
            $Scriptblock = [Scriptblock]::Create("$CommandName -limit 1 $Table")
            $Output = $Scriptblock.Invoke()
            $Output | Should -Not -BeNullOrEmpty
            $Output | Should -BeOfType PSCustomObject
            ($Output | Get-member -membertype NoteProperty).Name | Should -Contain 'sys_id'        
        }
    }
    
    Describe "Function <_>" -ForEach $TableCommands.Where({$_ -like "Set-*"}) {
        BeforeAll {
            $CommandName = $_
            $Command = Get-Command -Name $CommandName

            Mock -CommandName Invoke-RestMethod -ParameterFilter { $Method -eq 'PATCH' } -MockWith { $RestMethodResponse }
        }

        It "Should inherit parameters from Set-SNOWObject" {
            $command.Definition | Should -BeLike "*DynamicParam*{*Import-DefaultParamSet*-TemplateFunction*Set-SNOWObject*}*"
        }

        It "Should use Invoke-SNOWTableUPDATE" {
            $command.Definition | Should -BeLike "*Invoke-SNOWTableUPDATE*"
        }

        It "Should return output when updating a record with -PassThru" {
            $Scriptblock = [Scriptblock]::Create("$CommandName -sys_id '574ed78647e92110d3e5fa8bd36d437e' -Properties @{'key'='value'} -PassThru $Table")
            $Output = $Scriptblock.Invoke() 
            $Output | Should -Not -BeNullOrEmpty
            $Output | Should -BeOfType PSCustomObject
            ($Output | Get-member -membertype NoteProperty).Name | Should -Contain 'sys_id'
        }

        It "Should return output when updating a record with -AsBatchRequest" {
            $ExpectedKeys = @('id','exclude_response_headers','method','body','url','headers') | Sort-Object

            $Scriptblock = [Scriptblock]::Create("$CommandName -sys_id '574ed78647e92110d3e5fa8bd36d437e' -Properties @{'key'='value'} -AsBatchRequest $Table")
            $Output = $Scriptblock.Invoke() 
            $Output | Should -Not -BeNullOrEmpty
            $Output | Should -BeOfType Hashtable
            $Output.Keys | Sort-Object | Should -Be $ExpectedKeys
        }

        It "Should not return output when updating a record without -PassThru" {
            $Scriptblock = [Scriptblock]::Create("$CommandName -sys_id '574ed78647e92110d3e5fa8bd36d437e' -Properties @{'key'='value'} $Table")
            $Output = $Scriptblock.Invoke() 
            $Output | Should -BeNullOrEmpty
        }
    }

    Describe "Function <_>" -ForEach $TableCommands.Where({$_ -like "New-*"}) {
        BeforeAll {
            $CommandName = $_
            $Command = Get-Command -Name $CommandName

            Mock -CommandName Invoke-RestMethod -ParameterFilter { $Method -eq 'POST' } -MockWith { $RestMethodResponse }
        }

        It "Should inherit parameters from New-SNOWObject" {
            $command.Definition | Should -BeLike "*DynamicParam*{*Import-DefaultParamSet*-TemplateFunction*New-SNOWObject*}*"
        }

        It "Should use Invoke-SNOWTableCREATE" {
            $command.Definition | Should -BeLike "*Invoke-SNOWTableCREATE*"
        }

        It "Should return output when creating a record with -PassThru" {
            $Scriptblock = [Scriptblock]::Create("$CommandName -Properties @{'key'='value'} -PassThru $Table")
            $Output = $Scriptblock.Invoke() 
            $Output | Should -Not -BeNullOrEmpty
            $Output | Should -BeOfType PSCustomObject
            ($Output | Get-member -membertype NoteProperty).Name | Should -Contain 'sys_id'
        }

        It "Should return output when creating a record with -AsBatchRequest" {
            $ExpectedKeys = @('id','exclude_response_headers','method','body','url','headers') | Sort-Object
            $Scriptblock = [Scriptblock]::Create("$CommandName -Properties @{'key'='value'} -AsBatchRequest $Table")
            $Output = $Scriptblock.Invoke() 
            $Output | Should -Not -BeNullOrEmpty
            $Output | Should -BeOfType Hashtable
            $Output.Keys | Sort-Object | Should -Be $ExpectedKeys
        }

        It "Should not return output when creating a record without -PassThru" {
            $Scriptblock = [Scriptblock]::Create("$CommandName -Properties @{'key'='value'} $Table")
            $Output = $Scriptblock.Invoke()
            $Output | Should -BeNullOrEmpty
        }
    }

    Describe "Function <_>" -ForEach $TableCommands.Where({$_ -like "Remove-*"}) {
        BeforeAll {
            $CommandName = $_
            $Command = Get-Command -Name $CommandName

            Mock -CommandName Invoke-RestMethod -ParameterFilter { $Method -eq 'DELETE' } -MockWith { }
        }

        It "Should inherit parameters from Remove-SNOWObject" {
            $command.Definition | Should -BeLike "*DynamicParam*{*Import-DefaultParamSet*-TemplateFunction*Remove-SNOWObject*}*"
        }

        It "Should use Invoke-SNOWTableDELETE" {
            $command.Definition | Should -BeLike "*Invoke-SNOWTableDELETE*"
        }

        It "Should return no output when removing a record" {
            $Scriptblock = [Scriptblock]::Create("$CommandName -sys_id cfce22d247e56110d3e5fa8bd36d4355 -Confirm:`$false $Table")
            $Output = $Scriptblock.Invoke() 
            $Output | Should -BeNullOrEmpty
        }
    }
}