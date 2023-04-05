function Remove-SNOWLocation {
    <#
    .SYNOPSIS
        Removes a cmn_location record in SNOW
    .DESCRIPTION
        Removes a record from the cmn_location table
    .NOTES
        Uses Remove-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Remove-SNOWLocation.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Remove-SNOWLocation -Sys_ID "<sys_id>"
        Removes a specific record in the table cmn_location
    #>  
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "")]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param ()
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Remove-SNOWObject" }

    Begin {
        $table = "cmn_location"
    }
    Process {
        Invoke-SNOWTableDELETE -table $table -Parameters $PSBoundParameters
    }
}

