function Get-SNOWTask {
    <#
    .SYNOPSIS
        Retrieves a task record from SNOW
    .DESCRIPTION
        Gets a record from the task table
    .NOTES
        Uses Get-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html
    .EXAMPLE
        Get-SNOWTask -limit 1 -verbose
        Returns a single record from task
    #>   

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
        [alias('service')]
        [string]
        $business_service,
        [Parameter()]
        [string]
        $closed_by,
        [Parameter()]
        [string]
        $close_notes,
        [Parameter()]
        [alias('configuration_item')]
        [string]
        $cmdb_ci,
        [Parameter()]
        [alias('additional_comments')]
        [string]
        $comments,
        [Parameter()]
        [string]
        $comments_and_work_notes,
        [Parameter()]
        [string]
        $company,
        [Parameter()]
        [string]
        $contact_type,
        [Parameter()]
        [string]
        $contract,
        [Parameter()]
        [string]
        $delivery_plan,
        [Parameter()]
        [string]
        $delivery_task,
        [Parameter()]
        [string]
        $description,
        [Parameter()]
        [string]
        $escalation,
        [Parameter()]
        [string]
        $impact,
        [Parameter()]
        [string]
        $location,
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
        $order,
        [Parameter()]
        [string]
        $parent,
        [Parameter()]
        [string]
        $priority,
        [Parameter()]
        [string]
        $reassignment_count,
        [Parameter()]
        [alias('transfer_reason')]
        [string]
        $route_reason,
        [Parameter()]
        [string]
        $service_offering,
        [Parameter()]
        [string]
        $short_description,
        [Parameter()]
        [string]
        $state,
        [Parameter()]
        [string]
        $urgency
    )
    DynamicParam { Import-DefaultParams -TemplateFunction "Get-SNOWObject" }

    Begin {
        $table = "task"
    }
    Process {
        Invoke-SNOWTableREAD -table $table -Parameters $PSBoundParameters
    }
}

