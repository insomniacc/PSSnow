$ModulePath = ($PSScriptRoot | Split-Path -parent) + "\src"
$ProjectName = $PSScriptRoot | Split-Path -parent | Split-Path -leaf
Import-Module "$ModulePath\$ProjectName.psd1" -Force -ErrorAction Stop

InModuleScope $ProjectName {
    BeforeAll {
        function New-SNOWGUID {
            (new-guid).guid -replace "-"
        }

        #Get mock data
        $CartItem = Import-Clixml -path "$PSScriptRoot\MockedResponses\Invoke-SNOWSCCart.xml"
        $CheckedOutCart = Import-Clixml -path "$PSScriptRoot\MockedResponses\Invoke-SNOWSCCart_CheckedOut.xml"
        $CartWithItem = Import-Clixml -path "$PSScriptRoot\MockedResponses\Get-SNOWSCCart_WithItem.xml"
        $CartEmpty = Import-Clixml -path "$PSScriptRoot\MockedResponses\Get-SNOWSCCart_Empty.xml"
        $Cart = $CartEmpty

        $Username = 'DummyUsername'
        $Password = 'DummyPassword'
        $Instance = 'DummyInstance'
        $SSPassword = $Password | ConvertTo-SecureString -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential ($Username, $SSPassword)
        Set-SNOWAuth -instance $Instance -credential $Credential


        Mock -CommandName Invoke-RestMethod -ParameterFilter { 
            $URI -like '*/add_to_cart' -and 
            $METHOD -eq "POST"
        } -MockWith {
            $script:Cart = $CartWithItem
            $CartItem
        }

        Mock -CommandName Invoke-RestMethod -ParameterFilter { 
            $URI -like '*/checkout' -and 
            $METHOD -eq "POST"
        } -MockWith {
            $script:Cart = $CartEmpty
            $CheckedOutCart
        }

        Mock -CommandName Invoke-RestMethod -ParameterFilter { 
            $URI -like '*/empty' -and 
            $METHOD -eq "DELETE" 
        } -MockWith {
            $script:Cart = $CartEmpty
        }

        Mock -CommandName Invoke-RestMethod -ParameterFilter { 
            $URI -like '*/cart' -and
            $METHOD -eq "GET"
        } -MockWith {
            $script:Cart
        }
    }

    Describe "New-SNOWSCCartItem" {
        BeforeEach {
            $script:Cart = $CartEmpty
        }

        It "Should add an item to the cart [w/o passthru]" {
            $ItemProperties = @{
                primary_contact  = New-SNOWGUID
                cost_center      = New-SNOWGUID
                ip_range         = "127.0.0.1"
                business_purpose = "testing"
            }
            $Output = New-SNOWSCCartItem -Sys_ID (New-SNOWGUID) -Properties $ItemProperties
            
            $script:Cart.result.none | Should -Not -BeNullOrEmpty
            $Output | Should -BeNullOrEmpty
            Should -Invoke Invoke-RestMethod -ParameterFilter {
                $URI -like '*/add_to_cart' -and 
                $METHOD -eq "POST"
            } -Exactly 1
        }

        It "Should add an item to the cart [passthru]" {
            $ItemProperties = @{
                primary_contact  = New-SNOWGUID
                cost_center      = New-SNOWGUID
                ip_range         = "127.0.0.1"
                business_purpose = "testing"
            }
            $Output = New-SNOWSCCartItem -Sys_ID (New-SNOWGUID) -Properties $ItemProperties -PassThru

            $script:Cart.result.none | Should -Not -BeNullOrEmpty
            $Output | Should -BeExactly $CartItem.result

            Should -Invoke Invoke-RestMethod -ParameterFilter {
                $URI -like '*/add_to_cart' -and 
                $METHOD -eq "POST"
            } -Exactly 1
        }
    }

    Describe "Invoke-SNOWSCCart" {
        BeforeEach {
            $script:Cart = $CartWithItem
        }

        It "Should -checkout and return the request" {
            $Output = Invoke-SNOWSCCart -CheckOut -PassThru
            $Output.request_number | Should -BeLike "REQ*"
            $script:Cart.result | Should -BeExactly $CartEmpty.result

            Should -Invoke Invoke-RestMethod -Exactly 1
        }

        It "Should -empty the current cart" {
            $Output = Invoke-SNOWSCCart -Empty
            $Output | Should -BeNullOrEmpty
            $script:Cart.result | Should -BeExactly $CartEmpty.result

            Should -Invoke Invoke-RestMethod -ParameterFilter {
                $URI -like '*/cart' -and
                $METHOD -eq "GET"
            } -Exactly 1
            Should -Invoke Invoke-RestMethod -ParameterFilter {
                $URI -like '*/empty' -and 
                $METHOD -eq "DELETE"
            } -Exactly 1
        }

        It "Should -empty a specific cart" {
            $Output = Invoke-SNOWSCCart -Empty -sys_id (New-SNOWGUID)
            $Output | Should -BeNullOrEmpty
            $script:Cart.result | Should -BeExactly $CartEmpty.result

            Should -Invoke Invoke-RestMethod -Exactly 1
        }
    }
}