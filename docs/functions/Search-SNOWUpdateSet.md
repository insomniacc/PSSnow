---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Search-SNOWUpdateSet.md
schema: 2.0.0
---

# Search-SNOWUpdateSet

## SYNOPSIS
Searches for update sets in ServiceNow.

## SYNTAX

```
Search-SNOWUpdateSet [[-Query] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function searches for update sets in ServiceNow by querying both 
the sys_remote_update_set and sys_update_set tables.

This function calls the ServiceNow API endpoints:
- api/now/table/sys_remote_update_set
- api/now/table/sys_update_set

## EXAMPLES

### EXAMPLE 1
```powershell
Search-SNOWUpdateSet -Query "name=MyUpdateSet"
```

Searches for update sets with the name "MyUpdateSet" in both the remote and local update set tables.

### EXAMPLE 2
```powershell
Search-SNOWUpdateSet -Query "name STARTSWITH dev"
```

Searches for update sets with names that start with "dev".

## PARAMETERS

### -Query
The query to filter the update sets by.
Uses ServiceNow query syntax.

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

