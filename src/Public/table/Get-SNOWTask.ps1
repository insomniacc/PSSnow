function Get-SNOWTask {
    <#
    .SYNOPSIS
        Retrieves a servicenow Task
    .DESCRIPTION
        Gets a record from the sc_task table
    .NOTES
        Uses Get-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html
    .EXAMPLE
        Get-SNOWTask -limit 1 -verbose
        Returns a single Task from the sc_task table
    #>

    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $parent,
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
        $state,
        [Parameter()]
        [string]
        $impact,
        [Parameter()]
        [boolean]
        $active,
        [Parameter()]
        [string]
        $priority,
        [Parameter()]
        [string]
        $request,
        [Parameter()]
        [string]
        $short_description,
        [Parameter()]
        [string]
        $delivery_task,
        [Parameter()]
        [string]
        $assignment_group,
        [Parameter()]
        [string]
        $closed_by,
        [Parameter()]
        [string]
        $urgency,
        [Parameter()]
        [string]
        $company,
        [Parameter()]
        [string]
        $assigned_to,
        [Parameter()]
        [string]
        $approval,
        [Parameter()]
        [string]
        $request_item
    )
    DynamicParam { Import-DefaultParams -TemplateFunction "Get-SNOWObject" }

    Begin {
        $table = "sc_task"
    }
    Process {
        Invoke-SNOWTableREAD -table $table -Parameters $PSBoundParameters
    }
}