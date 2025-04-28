---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Remove-SNOWUpdateSet.md
schema: 2.0.0
---

# Remove-SNOWUpdateSet

## SYNOPSIS
Removes a ServiceNow update set by directly deleting it.

## SYNTAX

```
Remove-SNOWUpdateSet [-sys_id] <String> [[-sys_class_name] <String>] [-ProgressAction <ActionPreference>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This function permanently deletes a ServiceNow update set using the ServiceNow REST API.
It calls the ServiceNow API endpoint: api/now/table/{table}/{sys_id}

WARNING: This operation is permanent and cannot be undone.

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-SNOWUpdateSet -sys_id "1234567890abcdef"
```

Removes the specified update set after confirmation.

### EXAMPLE 2
```powershell
Get-SNOWUpdateSet -Name "MyUpdateSet" | Remove-SNOWUpdateSet -Confirm:$false
```

Gets an update set by name and removes it without confirmation.

### EXAMPLE 3
```powershell
Remove-SNOWUpdateSet -sys_id "1234567890abcdef" -sys_class_name "custom_update_set"
```

Removes an update set with a custom class name.

## PARAMETERS

### -sys_id
The sys_id of the update set to remove.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sys_class_name
The system class name of the update set.
Defaults to 'sys_update_set'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Sys_update_set
Accept pipeline input: True (ByPropertyName)
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

