---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Remove-SNOWLocation.md
schema: 2.0.0
---

# Remove-SNOWLocation

## SYNOPSIS
Removes a cmn_location record in SNOW

## SYNTAX

```
Remove-SNOWLocation [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] -Sys_ID <String>
 [-RestrictDomain] [<CommonParameters>]
```

## DESCRIPTION
Removes a record from the cmn_location table

## EXAMPLES

### EXAMPLE 1
```powershell
"
Removes a specific record in the table cmn_location
```

## PARAMETERS

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
Aliases:

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

PSCustomObject. The full table record/s.
## NOTES
Uses Remove-SNOWObject as a template function.

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Remove-SNOWLocation.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Remove-SNOWLocation.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


