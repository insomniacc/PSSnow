---
external help file: PSServiceNow-help.xml
Module Name: PSServiceNow
online version: docs/functions/Get-SNOWSCTask.md
schema: 2.0.0
---

# Get-SNOWSCTask

## SYNOPSIS
Retrieves a servicenow Task

## SYNTAX

```
Get-SNOWSCTask [[-parent] <String>] [[-made_sla] <Boolean>] [[-number] <String>] [[-opened_by] <String>]
 [[-state] <String>] [[-impact] <String>] [[-active] <Boolean>] [[-priority] <String>] [[-request] <String>]
 [[-short_description] <String>] [[-delivery_task] <String>] [[-assignment_group] <String>]
 [[-closed_by] <String>] [[-urgency] <String>] [[-company] <String>] [[-assigned_to] <String>]
 [[-approval] <String>] [[-request_item] <String>] [-Sys_ID <String>] [-Query <String>] [-Fields <Array>]
 [-DisplayValue <String>] [-ExcludeReferenceLinks] [-Offset <Int32>] [-Limit <Int32>] [-RestrictDomain]
 [-SysParmView <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets a record from the sc_task table

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWTask -limit 1 -verbose
```

Returns a single Task from the sc_task table

## PARAMETERS

### -parent
{{ Fill parent Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -made_sla
{{ Fill made_sla Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -number
{{ Fill number Description }}

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

### -opened_by
{{ Fill opened_by Description }}

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

### -state
{{ Fill state Description }}

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

### -impact
{{ Fill impact Description }}

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

### -active
{{ Fill active Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -priority
{{ Fill priority Description }}

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

### -request
{{ Fill request Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -short_description
{{ Fill short_description Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -delivery_task
{{ Fill delivery_task Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -assignment_group
{{ Fill assignment_group Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closed_by
{{ Fill closed_by Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -urgency
{{ Fill urgency Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -company
{{ Fill company Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -assigned_to
{{ Fill assigned_to Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -approval
{{ Fill approval Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -request_item
{{ Fill request_item Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayValue
{{ Fill DisplayValue Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeReferenceLinks
{{ Fill ExcludeReferenceLinks Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Fields
{{ Fill Fields Description }}

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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
Position: Named
Default value: None
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Query
{{ Fill Query Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestrictDomain
{{ Fill RestrictDomain Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sys_ID
{{ Fill Sys_ID Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: SysID

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SysParmView
{{ Fill SysParmView Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

PSCustomObject. The full table record/s.
## NOTES
Uses Get-SNOWObject as a template function.

## RELATED LINKS

[https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWSCTask.md](https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWSCTask.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


