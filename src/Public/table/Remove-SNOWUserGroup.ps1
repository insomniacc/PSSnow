function Remove-SNOWUserGroup {
    <#
    .SYNOPSIS
        Removes a sys_user_group record in SNOW
    .DESCRIPTION
        Removes a record from the sys_user_group table
    .NOTES
        Uses Remove-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Remove-SNOWUserGroup.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Remove-SNOWUserGroup -Sys_ID "<sys_id>"
        Removes a specific record in the table sys_user_group
    #>  
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "")]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param ()
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Remove-SNOWObject" }

    Begin {
        $table = "sys_user_group"
    }
    Process {
        Invoke-SNOWTableDELETE -table $table -Parameters $PSBoundParameters
    }
}

