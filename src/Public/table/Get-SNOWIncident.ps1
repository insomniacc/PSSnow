function Get-SNOWIncident {
    <#
    .SYNOPSIS
        Retrieves a servicenow Incident
    .DESCRIPTION
        Gets a record from the incident table
    .NOTES
        Uses Get-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWIncident.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Get-SNOWIncident -limit 1 -verbose
        Returns a single Incident
    #>   

    [CmdletBinding()]
    param ( 
        [Parameter()]
        [boolean]
        $made_sla,
        [Parameter()]
        [string]
        $number,
        [Parameter()]
        [string]
        $resolved_by,
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
        $business_impact,
        [Parameter()]
        [string]
        $priority,
        [Parameter()]
        [string]
        $caller_id,
        [Parameter()]
        [string]
        $short_description,
        [Parameter()]
        [string]
        $assignment_group,
        [Parameter()]
        [string]
        $notify,
        [Parameter()]
        [string]
        $closed_by,
        [Parameter()]
        [string]
        $parent_incident,
        [Parameter()]
        [string]
        $contact_type,
        [Parameter()]
        [string]
        $reopened_by,
        [Parameter()]
        [string]
        $incident_state,
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
        $severity,
        [Parameter()]
        [string]
        $approval,
        [Parameter()]
        [string]
        $reopen_count,
        [Parameter()]
        [string]
        $escalation,
        [Parameter()]
        [string]
        $location,
        [Parameter()]
        [string]
        $category
    )
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Get-SNOWObject" }

    Begin {
        $table = "incident"
    }
    Process {
        Invoke-SNOWTableREAD -table $table -Parameters $PSBoundParameters
    }
}