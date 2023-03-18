---
external help file: PSServiceNow-help.xml
Module Name: PSServiceNow
online version: docs/functions/Get-SNOWObject.md
schema: 2.0.0
---

# Get-SNOWObject

## SYNOPSIS
Retrieves a servicenow table API object

## SYNTAX

```
Get-SNOWObject [-Table] <String> [[-Sys_ID] <String>] [[-Query] <String>] [[-Fields] <Array>]
 [[-DisplayValue] <String>] [-ExcludeReferenceLinks] [[-Offset] <Int32>] [[-Limit] <Int32>] [-RestrictDomain]
 [[-SysParmView] <String>] [<CommonParameters>]
```

## DESCRIPTION
A template function for getting records from the table API

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWObject -table 'sys_user' -limit 1 -verbose
```

Returns a single user from the sys_user table

### EXAMPLE 2
```powershell
Get-SNOWObject -table 'sc_request' -query 'active=true' -limit 1
```

Returns a single user from the sys_user table

## PARAMETERS

### -Table
{{ Fill Table Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: sys_class_name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Sys_ID
{{ Fill Sys_ID Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: SysID

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Query
Can be copied directly from the snow web gui

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

### -Fields
Which fields should be returned

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeReferenceLinks
Removes http links from reference fields

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

### -Offset
{{ Fill Offset Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit
{{ Fill Limit Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestrictDomain
Restricts the record search to only the domains for the logged in user.
Only available to system administrators or query_no_domain_table_api role.

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

### -SysParmView
UI view for which to render the data.
Determines the fields returned in the response.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

String. Any servicenow object with a sys_id property.
## OUTPUTS

PSCustomObject. The full table record/s.
## NOTES
Queries can be copied directly from SNOW by right clicking on the end of the query string, this can be used within the query parameter.

## RELATED LINKS

[https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWObject.md](https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWObject.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


