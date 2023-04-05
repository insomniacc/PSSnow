function Get-SNOWDepartment {
    <#
    .SYNOPSIS
        Retrieves a cmn_department record from SNOW
    .DESCRIPTION
        Gets a record from the cmn_department table
    .NOTES
        Uses Get-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWDepartment.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Get-SNOWDepartment -limit 1 -verbose
        Returns a single record from cmn_department
    #>   

    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $business_unit,
        [Parameter()]
        [string]
        $company,
        [Parameter()]
        [string]
        $cost_center,
        [Parameter()]
        [alias('department_head')]
        [string]
        $dept_head,
        [Parameter()]
        [string]
        $description,
        [Parameter()]
        [string]
        $head_count,
        [Parameter()]
        [string]
        $id,
        [Parameter()]
        [string]
        $name,
        [Parameter()]
        [string]
        $parent,
        [Parameter()]
        [string]
        $primary_contact
    )
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Get-SNOWObject" }

    Begin {
        $table = "cmn_department"
    }
    Process {
        Invoke-SNOWTableREAD -table $table -Parameters $PSBoundParameters
    }
}

