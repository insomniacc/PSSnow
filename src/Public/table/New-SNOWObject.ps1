function New-SNOWObject {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Table,
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
        Invoke-SNOWTableCREATE -table $Table -Parameters $PSBoundParameters

        <#todo 
            https://docs.servicenow.com/bundle/tokyo-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html
            sysparm_display_value
            sysparm_exclude_reference_link
            sysparm_fields
            sysparm_view
            sysparm_query_no_domain

        #>
    }
}