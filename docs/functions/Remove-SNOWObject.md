---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Remove-SNOWObject.md
schema: 2.0.0
---

# Remove-SNOWObject

## SYNOPSIS
Removes a new servicenow record in the specified table

## SYNTAX

```
Remove-SNOWObject [-Sys_ID] <String> [-Table] <String> [-RestrictDomain] [-ProgressAction <ActionPreference>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a new servicenow record in the specified table

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-SNOWObject -table "sys_user" -sys_id "02826bf03710200044e0bfc8bcbe5d3f" -confirm:$false
Removes the specified user with the matching sys_id from the sys_user table and bypasses confirmation
```

### EXAMPLE 2
```powershell
Get-SNOWUser -user_name 'bruce.wayne9' -limit 1 | Remove-SNOWObject -table 'sys_user'
Removes the specified user with the matching sys_id from the sys_user table, after prompt confirmation
```

## PARAMETERS

### -Sys_ID
{{ Fill Sys_ID Description }}

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

### -Table
{{ Fill Table Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: sys_class_name

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Default value: False
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

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Remove-SNOWObject.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Remove-SNOWObject.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


