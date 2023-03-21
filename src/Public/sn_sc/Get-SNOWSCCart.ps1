function Get-SNOWSCCart {
    <#
    .SYNOPSIS
        Gets the current cart
    .DESCRIPTION
        returns the current cart properties
    .EXAMPLE
        Get-SNOWSCCart
        returns the cart object, no parameters required.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWSCCart.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_ServiceCatalogAPI.html&version=latest
    #>
    [CmdletBinding()]
    param()
    
    Assert-SNOWAuth
    $URI = "https://$($Script:SNOWAuth.Instance).service-now.com/api/sn_sc/servicecatalog/cart"
    $Headers = Get-AuthHeader

    $Response = Invoke-RestMethod -Uri $URI -Headers $Headers
    if($Response){
        return $Response.Result
    }
}