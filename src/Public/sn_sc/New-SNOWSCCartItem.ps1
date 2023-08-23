function New-SNOWSCCartItem {
    <#
    .SYNOPSIS
        Adds the specified item to the cart of the current user
    .DESCRIPTION
        Adds an item to the service catalog cart. Checkout can also be initiated using -checkout.
    .EXAMPLE
        #todo
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWSCCartItem.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_ServiceCatalogAPI.html&version=latest
    .NOTES
        While using this function it is possible to bypass any validation that may be present on the web form.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [string]
        # The sys_id for the catalog item 
        $Sys_ID,
        [Parameter()]
        [hashtable]
        $Properties,
        [Parameter()]
        [ValidateRange(0, [int]::MaxValue)]
        [int]
        $Quantity = 1,
        [Parameter()]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [string]
        $RequestedFor,
        [Parameter()]
        [ValidateCount(0,50)]
        [ValidateScript({ $_ | ForEach-Object { $_ | Confirm-SysID -ValidateScript }})]
        [array]
        #An array of sys_id's to order the item for. If the associated item does not have the requested_for variable set, the request is rejected.
        $AlsoRequestFor,
        [Parameter()]
        [switch]
        $Checkout,
        [Parameter()]
        [switch]
        $PassThru
    )

    Begin {
        $BaseURL = "https://$($Script:SNOWAuth.Instance).service-now.com/api/sn_sc/servicecatalog/items"
        $Headers = @{
            'Accept'       = 'application/json'
            'Content-Type' = 'application/json'
        }
    }
    Process {
        $URI = "$BaseURL/$Sys_ID/add_to_cart"
        $Body = @{
            variables = $Properties
            sysparm_quantity = $Quantity
        } 

        if($RequestedFor){
            $Body += @{
                sysparm_requested_for = $RequestedFor
            }
        }
        if($AlsoRequestFor){
            $Body += @{
                sysparm_also_request_for = $AlsoRequestFor -join ","
            }
        }

        $Body = $Body | ConvertTo-Json -Compress -Depth 10
        

        if($PSCmdlet.ShouldProcess($URI,'POST')){
            $RestSplat = @{
                Method = "POST"
                Headers = $Headers
                URI = $URI
                Body = $Body
            }
            $Response = Invoke-SNOWWebRequest -UseRestMethod @RestSplat
            if($Response){
                $Response = $Response.result
            }

            if($Checkout.IsPresent){
                $Response = Invoke-SNOWSCCart -Checkout -PassThru
            }

            if($Response -and $PassThru.IsPresent){
                return $Response
            }
        }
    }
}