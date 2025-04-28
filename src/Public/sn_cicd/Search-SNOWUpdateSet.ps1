function Search-SNOWUpdateSet {
    <#
    .SYNOPSIS
        Searches for update sets in ServiceNow.

    .DESCRIPTION
        This function searches for update sets in ServiceNow by querying both 
        the sys_remote_update_set and sys_update_set tables.
        
        This function calls the ServiceNow API endpoints:
        - api/now/table/sys_remote_update_set
        - api/now/table/sys_update_set

    .PARAMETER Query
        The query to filter the update sets by. Uses ServiceNow query syntax.

    .EXAMPLE
        Search-SNOWUpdateSet -Query "name=MyUpdateSet"
        
        Searches for update sets with the name "MyUpdateSet" in both the remote and local update set tables.
        
    .EXAMPLE
        Search-SNOWUpdateSet -Query "name STARTSWITH dev"
        
        Searches for update sets with names that start with "dev".
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Query
    )
    
    process {
        return @{
            sys_remote_update_set = (Get-SNOWObject -Table "sys_remote_update_set" -Query $Query )
            sys_update_set        = (Get-SNOWObject -Table "sys_update_set" -Query $Query ) 
        }
    }
}
