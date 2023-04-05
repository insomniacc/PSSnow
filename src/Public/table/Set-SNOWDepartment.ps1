function Set-SNOWDepartment {
    <#
    .SYNOPSIS
        Updates a cmn_department record in SNOW
    .DESCRIPTION
        Updates a record from the cmn_department table
    .NOTES
        Uses Set-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s (-PassThru only).
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWDepartment.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Set-SNOWDepartment -Sys_ID "<sys_id>" -Properties @{"<key>"="<value>"} -verbose
        Updates a specific record in the table cmn_department
    #>  
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "")]
    [CmdletBinding(SupportsShouldProcess)]
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
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Set-SNOWObject" }

    Begin {
        $table = "cmn_department"
    }
    Process {
        Invoke-SNOWTableUPDATE -table $table -Parameters $PSBoundParameters
    }
}

