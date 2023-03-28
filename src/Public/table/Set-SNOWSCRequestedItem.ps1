function Set-SNOWSCRequestedItem {
    <#
    .SYNOPSIS
        Updates a sc_req_item record in SNOW
    .DESCRIPTION
        Updates a record from the sc_req_item table
    .NOTES
        Uses Set-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s (-PassThru only).
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWSCRequestedItem.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Set-SNOWSCRequestedItem -Sys_ID "<sys_id>" -Properties @{"<key>"="<value>"} -verbose
        Updates a specific record in the table sc_req_item
    #>  
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [boolean]
        $backordered,
        [Parameter()]
        [boolean]
        $billable,
        [Parameter()]
        [alias('item')]
        [string]
        $cat_item,
        [Parameter()]
        [string]
        $configuration_item,
        [Parameter()]
        [string]
        $context,
        [Parameter()]
        [string]
        $estimated_delivery,
        [Parameter()]
        [string]
        $flow_context,
        [Parameter()]
        [string]
        $order_guide,
        [Parameter()]
        [string]
        $price,
        [Parameter()]
        [string]
        $quantity,
        [Parameter()]
        [alias('recurring_price_frequency')]
        [string]
        $recurring_frequency,
        [Parameter()]
        [string]
        $recurring_price,
        [Parameter()]
        [string]
        $request,
        [Parameter()]
        [string]
        $requested_for,
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
        [alias('closed')]
        [string]
        $closed_at,
        [Parameter()]
        [string]
        $closed_by,
        [Parameter()]
        [string]
        $close_notes,
        [Parameter()]
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
        $correlation_display,
        [Parameter()]
        [string]
        $correlation_id,
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
        $knowledge,
        [Parameter()]
        [string]
        $location,
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
        $reassignment_count,
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
        $time_worked,
        [Parameter()]
        [string]
        $universal_request,
        [Parameter()]
        [string]
        $upon_approval,
        [Parameter()]
        [string]
        $upon_reject,
        [Parameter()]
        [string]
        $urgency,
        [Parameter()]
        [string]
        $user_input,
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
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Set-SNOWObject" }

    Begin {
        $table = "sc_req_item"
    }
    Process {
        Invoke-SNOWTableUPDATE -table $table -Parameters $PSBoundParameters
    }
}

