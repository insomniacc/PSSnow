function Invoke-SNOWSCCart {
    <#
    .SYNOPSIS
        Can be used to checkout or empty a cart
    .DESCRIPTION
        either processes a cart or clears the contents depending on paramters
    .EXAMPLE
        New-SNOWSCCartItem -Sys_ID "e91336da4fff0200086eeed18110c7a3" -Properties @{
            primary_contact  = "a8f98bb0eb32010045e1a5115206fe3a"
            cost_center      = "a581ab703710200044e0bfc8bcbe5de8"
            ip_range         = "127.0.0.1"
            business_purpose = "testing"
        }
        Invoke-SNOWSCCart -Checkout -PassThru
    .EXAMPLE
        New-SNOWSCCartItem -Sys_ID "e91336da4fff0200086eeed18110c7a3" -Properties @{
            primary_contact  = "a8f98bb0eb32010045e1a5115206fe3a"
            cost_center      = "a581ab703710200044e0bfc8bcbe5de8"
            ip_range         = "127.0.0.1"
            business_purpose = "testing"
        }
        Invoke-SNOWSCCart -Empty
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Invoke-SNOWSCCart.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_ServiceCatalogAPI.html&version=latest
    .NOTES
        If one-step checkout, the method checks out (saves) the cart and returns the request number and the request order ID. 
        If two-step checkout, the method returns the cart order status and all the information required for two-step checkout.
    #>
    [CmdletBinding(SupportsShouldProcess,DefaultParameterSetName='checkout')]
    param(
        [Parameter(ParameterSetName='empty')]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [string]
        $Sys_id,
        [Parameter(ParameterSetName='empty')]
        [switch]
        $Empty,
        [Parameter(ParameterSetName='checkout')]
        [switch]
        $Checkout,
        [Parameter(ParameterSetName='checkout')]
        [switch]
        $PassThru
    )
    
    Assert-SNOWAuth
    $URI = "https://$($Script:SNOWAuth.Instance).service-now.com/api/sn_sc/servicecatalog/cart/"
    $Headers = Get-AuthHeader
    $Headers.Add('Accept','application/json')
    $Headers.Add('Content-Type','application/json')

    if($Checkout.IsPresent){
        $URI = $URI + "checkout"
        $Method = "POST"
    }

    if($Empty){
        if(-not $sys_id){
            $sys_id = (Get-SNOWSCCart).cart_id
        }
        $URI = $URI + "$sys_id/empty"
        $Method = "DELETE"
    }

    if($PSCmdlet.ShouldProcess($URI,$Method)){
        $ProxyAuth = $script:SNOWAuth.ProxyAuth
        $Response = Invoke-RestMethod -Method $Method -Uri $URI -Headers $Headers @ProxyAuth
        if($Response -and $PassThru.IsPresent){
            return $Response.Result
        }
    }
}