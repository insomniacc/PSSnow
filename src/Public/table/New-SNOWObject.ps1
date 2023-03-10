function New-SNOWObject {
    <#
    .SYNOPSIS
        Creates a new servicenow table record
    .DESCRIPTION
        Creates a record in the specified table
    .OUTPUTS
        PSCustomObject. The full table record (requires -passthru).
    .LINK
        https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html
    .EXAMPLE
        $Properties = @{
            user_name = "bruce.wayne"
            title = "Director"
            first_name = "Bruce"
            last_name = "Wayne"
            department = "Finance"
            email = "Bruce@WayneIndustries.com"
        }
        New-SNOWObject -Table 'sys_user' -Properties $Properties -PassThru
        Creates a new user called bruce wayne in the sys_user table
    #> 

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Table,
        [Parameter()]
        [hashtable]
        # Keys must exactly match the names in the snow table. Not the display values in the web front end. Case sensitive.
        $Properties,
        [Parameter()]
        [switch]
        # This flag is required when setting encrypted fields (e.g user_password)
        $InputDisplayValue,
        [Parameter()]
        [switch]
        $PassThru,
        [Parameter(DontShow)]
        [switch]
        $AsBatchRequest
     )

    Process {
        Invoke-SNOWTableCREATE -table $Table -Parameters $PSBoundParameters
    }
}