---
external help file: PSServiceNow-help.xml
Module Name: PSServiceNow
online version: docs/functions/Get-SNOWStatistic.md
schema: 2.0.0
---

# Get-SNOWStatistic

## SYNOPSIS
Used to interact with the aggregate API to get statistics on table data

## SYNTAX

```
Get-SNOWStatistic [-Table] <String> [[-Fields] <Array>] [[-FieldAggregation] <String>]
 [[-DisplayValue] <String>] [[-GroupBy] <Array>] [[-OrderBy] <String>] [[-Query] <Object>]
 [[-HavingQuery] <String>] [-Count] [<CommonParameters>]
```

## DESCRIPTION
Retrieves records for the specified table and performs aggregate functions to return statistics.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWStatistic -Table "sys_user" -Query "active=true" -Count
```

Returns the count of active users in the user table

## PARAMETERS

### -Table
{{ Fill Table Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Fields
List of fields on which to perform each aggregate operation.

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FieldAggregation
The aggregation function to perform on the fields parameter

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayValue
The query returns either the display value, the actual value in the database, or both.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupBy
Fields by which to group the returned data

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OrderBy
You can specify an order using, fields or an aggregate including COUNT.
E.g, 'AVG^state'.
Ascending by default.
Use ^DESC to sort in descending order, E.g 'state^DESC'

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Query
A ServiceNow encoded query, can be copied directly from the web ui

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HavingQuery
Additional query to filter based on an aggregate operation.
e.g 'count^priority^\>^3' to obtain the number of records within the query results with a priority greater than 3.
You can specify multiple queries by separating each with a comma.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Count
Flag that determines whether to return the number of records returned by the query.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For Aggregate API requests, you must have read access for all records in the table you query.
If an ACL prevents the requesting user from accessing any record in the table, the request returns a 403 Forbidden error.

## RELATED LINKS

[https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWStatistic.md](https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWStatistic.md)

[https://docs.servicenow.com/csh?topicname=c_AggregateAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_AggregateAPI.html&version=latest)


