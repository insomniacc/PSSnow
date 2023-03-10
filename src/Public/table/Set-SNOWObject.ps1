function Set-SNOWObject {
    <#
    .SYNOPSIS
        Updates a new servicenow record
    .DESCRIPTION
        Updates a record in the specified table
    .OUTPUTS
        PSCustomObject. The full table record (requires -passthru).
    .LINK
        https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html
    .EXAMPLE
        Get-SNOWObject -table "sys_user" -query "user_name=bruce.wayne^active=true" | Set-SNOWObject -table "sys_user" -middle_name "Thomas"
        Updates the middle_name of the user record bruce.wayne in the sys_user table
    .EXAMPLE
        Set-SNOWObject -table "sys_user" -sys_id '02826bf03710200044e0bfc8bcbe5d3f' -properties @{middle_name="Thomas"}
        Updates the middle_name of the user record bruce.wayne in the sys_user table
    #> 

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Table,
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [ValidateScript({
            if($_ -match "^[0-9a-f]{32}$"){
                $true
            }else{
                Throw "Must be a valid sys_id"
            }
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