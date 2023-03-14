function Get-SNOWSCRequest {
    <#
    .SYNOPSIS
        Retrieves a servicenow Request
    .DESCRIPTION
        Gets a record from the sc_request table
    .NOTES
        Uses Get-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html
    .EXAMPLE
        Get-SNOWRequest -limit 1 -verbose
        Returns a single Request from the sc_request
    #>   

    [CmdletBinding()]
    param (
        [Parameter()]
        [boolean]    
        $made_sla,
        [Parameter()]
        [string]
        $requested_for,
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
        $short_description,
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
        $request_state,
        [Parameter()]
        [string]
        $stage,
        [Parameter()]
        [string]
        $location
    )
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Get-SNOWObject" }

    Begin {
        $table = "sc_request"
    }
    Process {
        Invoke-SNOWTableREAD -table $table -Parameters $PSBoundParameters
    }
}