function Remove-SNOWObject {
    <#
    .SYNOPSIS
        Removes a new servicenow record in the specified table
    .DESCRIPTION
        Removes a new servicenow record in the specified table
    .LINK
        https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html
    .EXAMPLE
        Remove-SNOWObject -table "sys_user" -sys_id "02826bf03710200044e0bfc8bcbe5d3f" -confirm:$false
        Removes the specified user with the matching sys_id from the sys_user table and bypasses confirmation
    .EXAMPLE
        Get-SNOWUser -user_name 'bruce.wayne9' -limit 1 | Remove-SNOWObject -table 'sys_user'
        Removes the specified user with the matching sys_id from the sys_user table, after prompt confirmation
    #> 

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param (      
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [string]
        $Sys_ID,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Table,
        [Parameter()]
        [switch]
        $RestrictDomain = $false
    )

    Process {
        Invoke-SNOWTableDELETE -table $Table -Parameters $PSBoundParameters
    }
}