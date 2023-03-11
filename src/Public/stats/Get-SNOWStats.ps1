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
        # List of fields on which to perform each aggregate operation.
        $Fields,
        [Parameter(ParameterSetName='fields')]
        [ValidateSet('avg','max','min','sum')]
        [string]
        #The aggregation function to perform on the fields parameter
        $FieldAggregation,
        [Parameter()]
        [ValidateSet('true','false','all')]
        [string]
        #The query returns either the display value, the actual value in the database, or both.
        $DisplayValue,
        [Parameter()]
        [array]
        #Fields by which to group the returned data
        $GroupBy,
        [Parameter()]
        [string]
        #You can specify an order using, fields or an aggregate including COUNT. E.g, 'AVG^state'. Ascending by default. Use ^DESC to sort in descending order, E.g 'state^DESC'
        $OrderBy,
        [Parameter()]
        #A ServiceNow encoded query, can be copied directly from the web ui
        $Query,
        [Parameter(ParameterSetName='having')]
        [string]
        #Additional query to filter based on an aggregate operation. e.g 'count^priority^>^3' to obtain the number of records within the query results with a priority greater than 3. You can specify multiple queries by separating each with a comma.
        $HavingQuery,
        [Parameter()]
        [switch]
        #Flag that determines whether to return the number of records returned by the query.
        $Count
    )
    
    begin {
        Assert-SNOWAuth
        $URI = "https://$($script:SNOWAuth.Instance).service-now.com/api/now/v1/stats/$Table`?"
    }
    
    process {
        Switch ($PSBoundParameters.Keys) {
            'Fields'        {$URI += "&sysparm_$FieldAggregation`_fields=$($Fields -join ',')"}
            'DisplayValue'  {$URI += "&sysparm_display_value=$DisplayValue"}
            'GroupBy'       {$URI += "&sysparm_group_by=$($GroupBy -join ',')"}
            'OrderBy'       {$URI += "&sysparm_orderby=$OrderBy"}
            'Query'         {$URI += "&sysparm_query=$Query"}
            'HavingQuery'   {$URI += "&sysparm_having=$HavingQuery"}
            'Count'         {$URI += "&sysparm_count=$($Count.IsPresent.ToString().ToLower())"}
        }

        $Response = Invoke-RestMethod -URI $URI -Credential $script:SNOWAuth.Credential
        if($Response){
            return $Response.result
        }
    }
  }