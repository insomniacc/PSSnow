function Get-SNOWUpdateSet {
    <#
    .SYNOPSIS
        Get update set from ServiceNow by sys_id. Searches sys_update_set and sys_remote_update_set tables in order.

    .DESCRIPTION
        This function retrieves update sets from ServiceNow by their system ID.
        It searches both sys_update_set and sys_remote_update_set tables.
        
        This function calls the ServiceNow API endpoints via Search-SNOWUpdateSet:
        - api/now/table/sys_update_set
        - api/now/table/sys_remote_update_set

    .PARAMETER sys_id
        The system ID (sys_id) of the update set to retrieve.

    .EXAMPLE
        Get-SNOWUpdateSet -sys_id "1234567890abcdef"
        
        Retrieves the update set with the specified sys_id.
        
    .EXAMPLE
        "1234567890abcdef" | Get-SNOWUpdateSet
        
        Retrieves the update set by piping the sys_id.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$sys_id
    )

    process {
        $result = Search-SNOWUpdateSet -Query "sys_id=$sys_id"
        if ($result.sys_update_set) {
            $result.sys_update_set
        }
        elseif ($result.sys_remote_update_set) {
            $result.sys_remote_update_set
        }
        else {
            $null
        }
    }
}
