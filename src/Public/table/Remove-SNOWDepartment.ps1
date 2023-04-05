function Remove-SNOWDepartment {
    <#
    .SYNOPSIS
        Removes a cmn_department record in SNOW
    .DESCRIPTION
        Removes a record from the cmn_department table
    .NOTES
        Uses Remove-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Remove-SNOWDepartment.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Remove-SNOWDepartment -Sys_ID "<sys_id>"
        Removes a specific record in the table cmn_department
    #>  
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "")]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param ()
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Remove-SNOWObject" }

    Begin {
        $table = "cmn_department"
    }
    Process {
        Invoke-SNOWTableDELETE -table $table -Parameters $PSBoundParameters
    }
}

