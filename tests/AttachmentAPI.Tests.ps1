$ModulePath = ($PSScriptRoot | Split-Path -parent) + "\src"
$ProjectName = $PSScriptRoot | Split-Path -parent | Split-Path -leaf
Import-Module "$ModulePath\$ProjectName.psd1" -Force -ErrorAction Stop

InModuleScope $ProjectName {
    BeforeAll {
        #Get mock data
        #$RestMethodResponse = Import-Clixml "$PSScriptRoot\MockedResponses\New-SNOWAttachment.xml"

        $Username = 'DummyUsername'
        $Password = 'DummyPassword'
        $Instance = 'DummyInstance'
        $SSPassword = $Password | ConvertTo-SecureString -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential ($Username, $SSPassword)
        Set-SNOWAuth -instance $Instance -credential $Credential
    }

    Describe "New-SNOWAttachment" {}
    Describe "Get-SNOWAttachment" {}
    Describe "Set-SNOWAttachment" {}
    Describe "Remove-SNOWAttachment" {}
    Describe "Set-SNOWUserPhoto" {}
}