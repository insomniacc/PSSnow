---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Set-SNOWDepartment.md
schema: 2.0.0
---

# Set-SNOWDepartment

## SYNOPSIS
Updates a cmn_department record in SNOW

## SYNTAX

```
Set-SNOWDepartment [[-business_unit] <String>] [[-company] <String>] [[-cost_center] <String>]
 [[-dept_head] <String>] [[-description] <String>] [[-head_count] <String>] [[-id] <String>] [[-name] <String>]
 [[-parent] <String>] [[-primary_contact] <String>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 -Sys_ID <String> [-Properties <Hashtable>] [-InputDisplayValue] [-PassThru] [-AsBatchRequest]
 [<CommonParameters>]
```

## DESCRIPTION
Updates a record from the cmn_department table

## EXAMPLES

### EXAMPLE 1
```powershell
" -Properties @{"<key>"="<value>"} -verbose
Updates a specific record in the table cmn_department
```

## PARAMETERS

### -business_unit
{{ Fill business_unit Description }}

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

### -company
{{ Fill company Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cost_center
{{ Fill cost_center Description }}

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

### -dept_head
{{ Fill dept_head Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: department_head

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
{{ Fill description Description }}

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

### -head_count
{{ Fill head_count Description }}

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

### -id
{{ Fill id Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
{{ Fill name Description }}

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

### -parent
{{ Fill parent Description }}

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

### -primary_contact
{{ Fill primary_contact Description }}

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsBatchRequest
{{ Fill AsBatchRequest Description }}

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

### -InputDisplayValue
{{ Fill InputDisplayValue Description }}

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

### -PassThru
{{ Fill PassThru Description }}

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

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: System.Management.Automation.ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Properties
{{ Fill Properties Description }}

```yaml
Type: System.Collections.Hashtable
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

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

PSCustomObject. The full table record/s (-PassThru only).
## NOTES
Uses Set-SNOWObject as a template function.

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWDepartment.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWDepartment.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


