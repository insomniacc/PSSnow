---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Get-SNOWUpdateSet.md
schema: 2.0.0
---

# Get-SNOWUpdateSet

## SYNOPSIS
Get update set from ServiceNow by sys_id.
Searches sys_update_set and sys_remote_update_set tables in order.

## SYNTAX

```
Get-SNOWUpdateSet [-sys_id] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function retrieves update sets from ServiceNow by their system ID.
It searches both sys_update_set and sys_remote_update_set tables.

This function calls the ServiceNow API endpoints via Search-SNOWUpdateSet:
- api/now/table/sys_update_set
- api/now/table/sys_remote_update_set

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWUpdateSet -sys_id "1234567890abcdef"
```

Retrieves the update set with the specified sys_id.

### EXAMPLE 2
```powershell
"1234567890abcdef" | Get-SNOWUpdateSet
```

Retrieves the update set by piping the sys_id.

## PARAMETERS

### -sys_id
The system ID (sys_id) of the update set to retrieve.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

