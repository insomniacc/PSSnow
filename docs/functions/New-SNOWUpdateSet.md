---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/New-SNOWUpdateSet.md
schema: 2.0.0
---

# New-SNOWUpdateSet

## SYNOPSIS
Creates a new update set in ServiceNow using the CICD API.

## SYNTAX

### BySysId (Default)
```
New-SNOWUpdateSet -Name <String> [-Description <String>] -ApplicationSysId <String>
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByScope
```
New-SNOWUpdateSet -Name <String> [-Description <String>] -Scope <String> [-ProgressAction <ActionPreference>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new update set in ServiceNow using the CICD API.
Requires either the sys_id or scope to identify the application.

This function calls the ServiceNow API endpoint: api/sn_cicd/update_set/create

## EXAMPLES

### EXAMPLE 1
```powershell
New-SNOWUpdateSet -Name "My Update Set" -Description "Contains my changes" -ApplicationSysId "123456789"
```

Creates a new update set associated with the specified application sys_id.

### EXAMPLE 2
```powershell
New-SNOWUpdateSet -Name "Scoped Update Set" -Scope "x_myapp_scope"
```

Creates a new update set associated with the application having the specified scope.

### EXAMPLE 3
```powershell
New-SNOWUpdateSet -Name "Dev Changes" -Description "Bug fix for issue #123" -ApplicationSysId "123456789" -WhatIf
```

Shows what would happen if you created the update set, but doesn't actually create it.

## PARAMETERS

### -Name
The name of the update set to create.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Optional description for the update set.

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

### -ApplicationSysId
The sys_id of the application to associate the update set with.

```yaml
Type: System.String
Parameter Sets: BySysId
Aliases: SysId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
The scope name of the application to associate the update set with.

```yaml
Type: System.String
Parameter Sets: ByScope
Aliases:

Required: True
Position: Named
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

