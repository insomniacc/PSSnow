$ModulePath = ($PSScriptRoot | Split-Path -parent) + "\src"
$ProjectName = $PSScriptRoot | Split-Path -parent | Split-Path -leaf
Import-Module "$ModulePath\$ProjectName.psd1" -Force -ErrorAction Stop

InModuleScope $ProjectName {

    BeforeAll {
        #Get mock data
        $RestMethodResponse = Import-Clixml "$PSScriptRoot\MockedResponses\New-SNOWImport.xml"

        $Username = 'DummyUsername'
        $Password = 'DummyPassword'
        $Instance = 'DummyInstance'
        $SSPassword = $Password | ConvertTo-SecureString -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential ($Username, $SSPassword)
        Set-SNOWAuth -instance $Instance -credential $Credential
    }

    Describe "New-SNOWImport" {
        BeforeAll {
            Mock -CommandName Invoke-RestMethod -ParameterFilter { $URI -like "*import*" -and $Method -eq "POST" } -MockWith { $RestMethodResponse }
        }

        It "Should a result indicating successful import" {
            $Movies = @(
                @{
                    u_title    = "The Great Banana Heist"
                    u_director = "Benny Banana"
                    u_actor    = "Lily Lime"
                    u_genre    = "Crime/Comedy"
                },
                @{
                    u_title    = "The Revenge of the Ninja Hamsters"
                    u_director = "Hiroshi Hamada"
                    u_actor    = "Sakura Sushi"
                    u_genre    = "Martial Arts/Comedy"
                }
            )
            $Output = $Movies | New-SNOWImport -table "u_moviesimport"

            $Output.count | Should -BeExactly 2
            Should -Invoke Invoke-RestMethod -Exactly 2
        }
    }

}