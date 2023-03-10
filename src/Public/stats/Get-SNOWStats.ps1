  function Get-SNOWStats {
    <#
    .SYNOPSIS
        Used to interact with the aggregate API to get statistics on table data
    .DESCRIPTION
        Retrieves records for the specified table and performs aggregate functions to return statistics.
    .NOTES
        For Aggregate API requests, you must have read access for all records in the table you query. If an ACL prevents the requesting user from accessing any record in the table, the request returns a 403 Forbidden error.
    .LINK
        https://developer.servicenow.com/dev.do#!/reference/api/rome/rest/c_AggregateAPI
    .EXAMPLE
        Get-SNOWStats -Table "sys_user" -Query "active=true" -Count
        Returns the count of active users in the user table
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $Table,
        [Parameter(ParameterSetName='fields')]
        [array]
        $Fields,
        [Parameter(ParameterSetName='fields')]
        [ValidateSet('avg','max','min','sum')]
        [string]
        $FieldAggregation,
        [Parameter()]
        [ValidateSet('true','false','all')]
        [string]
        $DisplayValue,
        [Parameter()]
        [array]
        $GroupBy,
        [Parameter()]
        [string]
        $OrderBy,
        [Parameter()]
        $Query,
        [Parameter()]
        [string]
        $HavingQuery,
        [Parameter()]
        [switch]
        $Count
    )
    
    begin {
        Assert-SNOWAuth
        $URI = "https://$($script:SNOWAuth.Instance).service-now.com/api/now/v1/stats/$Table`?"
        
    }
    
    process {
        Switch ($PSBoundParameters.Keys) {
            'Fields' {$URI += "&sysparm_$FieldAggregation`_fields=$($Fields -join ',')"}
            'DisplayValue' {$URI += "&sysparm_display_value=$DisplayValue"}
            'GroupBy' {$URI += "&sysparm_group_by=$($GroupBy -join ',')"}
            'OrderBy' {$URI += "&sysparm_orderby=$OrderBy"}
            'Query' {$URI += "&sysparm_query=$Query"}
            'HavingQuery' {$URI += "&sysparm_having=$HavingQuery"}
            'Count' {$URI += "&sysparm_count=$($Count.IsPresent.ToString().ToLower())"}
        }

        $Response = Invoke-RestMethod -URI $URI -Credential $script:SNOWAuth.Credential
        if($Response){
            return $Response.result
        }
    }
  }