function New-SNOWTask {
    <#
    .SYNOPSIS
        Creates a task record in SNOW
    .DESCRIPTION
        Creates a record in the task table
    .NOTES
        Uses New-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s (-PassThru only).
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWTask.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        New-SNOWTask -Properties @{"<key>"="<value>"} -PassThru
        Creates a single record in task and returns the new record with SysID
    #>   
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [boolean]
        $active,
        [Parameter()]
        [string]
        $activity_due,
        [Parameter()]
        [string]
        $additional_assignee_list,
        [Parameter()]
        [string]
        $approval,
        [Parameter()]
        [string]
        $approval_history,
        [Parameter()]
        [string]
        $approval_set,
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
        $delivery_plan,
        [Parameter()]
        [string]
        $delivery_task,
        [Parameter()]
        [string]
        $description,
        [Parameter()]
        [string]
        $due_date,
        [Parameter()]
        [string]
        $expected_start,
        [Parameter()]
        [string]
        $follow_up,
        [Parameter()]
        [string]
        $group_list,
        [Parameter()]
        [string]
        $impact,
        [Parameter()]
        [boolean]
        $made_sla,
        [Parameter()]
        [alias('opened')]
        [string]
        $opened_at,
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
        $service_offering,
        [Parameter()]
        [string]
        $short_description,
        [Parameter()]
        [string]
        $sla_due,
        [Parameter()]
        [string]
        $state,
        [Parameter()]
        [string]
        $urgency,
        [Parameter()]
        [string]
        $watch_list,
        [Parameter()]
        [alias('actual_end')]
        [string]
        $work_end,
        [Parameter()]
        [string]
        $work_notes,
        [Parameter()]
        [string]
        $work_notes_list,
        [Parameter()]
        [alias('actual_start')]
        [string]
        $work_start
    )
    DynamicParam { Import-DefaultParamSet -TemplateFunction "New-SNOWObject" }

    Begin {
        $table = "task"
    }
    Process {
        Invoke-SNOWTableCREATE -table $table -Parameters $PSBoundParameters
    }
}

