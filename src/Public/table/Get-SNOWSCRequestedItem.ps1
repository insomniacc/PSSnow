function Get-SNOWSCRequestedItem {
    <#
    .SYNOPSIS
        Retrieves a servicenow RITM record
    .DESCRIPTION
        Gets a record from the sc_req_item table
    .NOTES
        Uses Get-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWSCRequestedItem.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Get-SNOWRequestedItem -limit 1 -verbose
        Returns a single RITM from the sc_req_item table
    #>   

    [alias("Get-SNOWRITM")]
    [CmdletBinding()]
    param (
        [Parameter()]
        [boolean]    
        $active,
        [Parameter()]
        [string]
        $approval,
        [Parameter()]
        [string]
        $assigned_to,
        [Parameter()]
        [string]
        $assignment_group,
        [Parameter()]
        [string]
        $business_service,
        [Parameter()]
        [string]
        $cat_item,
        [Parameter()]
        [string]
        $closed_by,
        [Parameter()]
        [string]
        $company,
        [Parameter()]
        [string]
        $configuration_item,
        [Parameter()]
        [string]
        $impact,
        [Parameter()]
        [boolean]
        $made_sla,
        [Parameter()]
        [string]
        $number,
        [Parameter()]
        [string]
        $opened_by,
        [Parameter()]
        [string]
        $priority,
        [Parameter()]
        [string]
        $request,
        [Parameter()]
        [string]
        $requested_for,
        [Parameter()]
        [string]
        $short_description,
        [Parameter()]
        [string]
        $stage,
        [Parameter()]
        [string]
        $state,
        [Parameter()]
        [string]
        $urgency,
        [Parameter()]
        [string]
        $order_guide
    )
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Get-SNOWObject" }

    Begin {
        $table = "sc_req_item"
    }
    Process {
        Invoke-SNOWTableREAD -table $table -Parameters $PSBoundParameters
    }
}