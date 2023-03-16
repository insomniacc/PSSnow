$global:ScriptRoot = $PSScriptRoot
$ProjectName = $global:ScriptRoot | Split-Path -parent | Split-Path -leaf
$global:ModulePath = ($global:ScriptRoot | Split-Path -parent) + "\src"

Import-Module "$global:ModulePath\$ProjectName.psd1" -Force -ErrorAction Stop

InModuleScope "PSServicenow" {
    Describe "Authentication" {
        BeforeAll {
            $Username = 'DummyUsername'
            $Password = 'DummyPassword'
            $Instance = 'DummyInstance'
            $SSPassword = $Password | ConvertTo-SecureString -AsPlainText -Force
            $Credential = New-Object PSCredential ($Username, $SSPassword)
            $Command = Get-Command Set-SNOWAuth
            Set-SNOWAuth -instance $Instance -credential $Credential
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

            It "Should set authentication in script scope" {
                $script:SNOWAuth | Should -BeOfType Hashtable
                $script:SNOWAuth.Instance | Should -BeExactly $Instance
                $script:SNOWAuth.Credential | Should -BeExactly $Credential
                $script:SNOWAuth.type | Should -BeExactly 'basic'
            }
        }
    }
}

#todo Get-SNOWRITMVariable