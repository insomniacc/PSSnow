function Set-SNOWPagination {
    <#
    .SYNOPSIS
        Sets ServiceNow pagination in the current session.
    .DESCRIPTION
       Applies module scope pagination for PSSNOW
    .EXAMPLE
       Set-SNOWPagination -Limit 2000
       Any pagination after this command will be set to 2000 until the session ends or the pagination is changed again.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [int]$Limit
    )

    Write-Verbose "Setting pagination to $Limit"
    $Script:SNOWPaginationDefault = $Limit
}
