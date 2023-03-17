function Set-SNOWApprover {
    <#
    .SYNOPSIS
        Updates a sysapproval_approver record in SNOW
    .DESCRIPTION
        Updates a record from the sysapproval_approver table
    .NOTES
        Uses Set-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Set-SNOWApprover.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Set-SNOWApprover -Sys_ID "<sys_id>" -Properties @{"<key>"="<value>"} -verbose
        Updates a specific record in the table sysapproval_approver
    #>  

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [string]
        $approver,
        [Parameter()]
        [string]
        $comments,
        [Parameter()]
        [string]
        $document_id,
        [Parameter()]
        [string]
        $due_date,
        [Parameter()]
        [string]
        $expected_start,
        [Parameter()]
        [string]
        $group,
        [Parameter()]
        [string]
        $source_table,
        [Parameter()]
        [string]
        $state,
        [Parameter()]
        [string]
        $sysapproval
    )
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Set-SNOWObject" }

    Begin {
        $table = "sysapproval_approver"
    }
    Process {
        Invoke-SNOWTableUPDATE -table $table -Parameters $PSBoundParameters
    }
}

