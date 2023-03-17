function Set-SNOWObject {
    <#
    .SYNOPSIS
        Updates a new servicenow record
    .DESCRIPTION
        Updates a record in the specified table
    .OUTPUTS
        PSCustomObject. The full table record (requires -PassThru).
    .LINK
        https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Set-SNOWObject.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Get-SNOWObject -table "sys_user" -query "user_name=bruce.wayne^active=true" | Set-SNOWObject -table "sys_user" -middle_name "Thomas"
        Updates the middle_name of the user record bruce.wayne in the sys_user table
    .EXAMPLE
        Set-SNOWObject -table "sys_user" -sys_id '02826bf03710200044e0bfc8bcbe5d3f' -properties @{middle_name="Thomas"}
        Updates the middle_name of the user record bruce.wayne in the sys_user table
    #> 

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [alias("sys_class_name")]
        [string]
        $Table,
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateScript({
            Confirm-SysID -Sys_ID $_ -ValidateScript
        })]
        [string]
        [alias('SysID')]
        $Sys_ID,
        [Parameter()]
        [hashtable]
        $Properties,
        [Parameter()]
        [switch]
        $InputDisplayValue,
        [Parameter()]
        [switch]
        $PassThru,
        [Parameter(DontShow)]
        [switch]
        $AsBatchRequest
     )

    Process {
        Invoke-SNOWTableUPDATE -table $Table -Parameters $PSBoundParameters
    }
}