function Get-SNOWSCOrderGuide {
    <#
    .SYNOPSIS
        Retrieves a sc_cat_item_guide record from SNOW
    .DESCRIPTION
        Gets a record from the sc_cat_item_guide table
    .NOTES
        Uses Get-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWSCOrderGuide.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Get-SNOWSCOrderGuide -limit 1 -verbose
        Returns a single record from sc_cat_item_guide
    #>   

    [CmdletBinding()]
    param (
        [Parameter()]
        [alias('cascade_variables')]
        [boolean]
        $cascade,
        [Parameter()]
        [alias('show_include_toggle')]
        [boolean]
        $include_items,
        [Parameter()]
        [boolean]
        $order_to_cart,
        [Parameter()]
        [string]
        $script,
        [Parameter()]
        [boolean]
        $two_step,
        [Parameter()]
        [string]
        $validator
    )
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Get-SNOWObject" }

    Begin {
        $table = "sc_cat_item_guide"
    }
    Process {
        Invoke-SNOWTableREAD -table $table -Parameters $PSBoundParameters
    }
}

