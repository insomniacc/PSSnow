function New-SNOWDepartment {
    <#
    .SYNOPSIS
        Creates a cmn_department record in SNOW
    .DESCRIPTION
        Creates a record in the cmn_department table
    .NOTES
        Uses New-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s (-PassThru only).
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWDepartment.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        New-SNOWDepartment -Properties @{"<key>"="<value>"} -PassThru
        Creates a single record in cmn_department and returns the new record with SysID
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
    DynamicParam { Import-DefaultParamSet -TemplateFunction "New-SNOWObject" }

    Begin {
        $table = "cmn_department"
    }
    Process {
        Invoke-SNOWTableCREATE -table $table -Parameters $PSBoundParameters
    }
}

