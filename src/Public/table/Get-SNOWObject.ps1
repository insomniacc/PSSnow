function Get-SNOWObject {
    <#
    .SYNOPSIS
        Retrieves a servicenow table API object
    .DESCRIPTION
        A template function for getting records from the table API
    .NOTES
        Queries can be copied directly from SNOW by right clicking on the end of the query string, this can be used within the query parameter.
    .INPUTS
        String. Any servicenow object with a sys_id property.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html
    .EXAMPLE
        Get-SNOWObject -table 'sys_user' -limit 1 -verbose
        Returns a single user from the sys_user table
    .EXAMPLE
        Get-SNOWObject -table 'sc_request' -query 'active=true' -limit 1
        Returns a single user from the sys_user table
    #>    

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Table,
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [string]
        [alias('SysID')]
        $Sys_ID,
        [Parameter()]
        [string]
        #Can be copied directly from the snow web gui
        $Query,
        [Parameter()]
        [array]
        #Which fields should be returned
        $Fields,
        [Parameter()]
        [ValidateSet("true","false","all")]
        [string]
        $DisplayValue,
        [Parameter()]
        [switch]
        #Removes http links from reference fields
        $ExcludeReferenceLinks,
        [Parameter()]
        [ValidateRange(0, [int]::MaxValue)]
        [int]
        $Offset,
        [Parameter()]
        [ValidateRange(0, [int]::MaxValue)]
        [int]
        $Limit,
        [Parameter()]
        [switch]
        #Restricts the record search to only the domains for the logged in user. Only available to system administrators or query_no_domain_table_api role.
        $RestrictDomain = $false,
        [Parameter(DontShow)]
        [ValidateSet("desktop","mobile","both")]
        [string]
        #UI view for which to render the data. Determines the fields returned in the response.
        $SysParmView
    )

    Process {
        Invoke-SNOWTableREAD -table $Table -Parameters $PSBoundParameters
    }
}