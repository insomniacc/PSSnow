---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Start-SNOWUpdateSetCommit.md
schema: 2.0.0
---

# Start-SNOWUpdateSetCommit

## SYNOPSIS
Starts the commit process for a ServiceNow update set.

## SYNTAX

```
Start-SNOWUpdateSetCommit [-sys_id] <String> [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This function starts the commit process for a ServiceNow update set using the CICD API.
It returns the raw result object from the API which can be piped to Wait-SNOWCICDProgress
to wait for the operation to complete.

This function calls the ServiceNow API endpoint: api/sn_cicd/update_set/commit/{sys_id}

## EXAMPLES

### EXAMPLE 1
```powershell
Start-SNOWUpdateSetCommit -sys_id "1234567890abcdef"
```

Starts the commit process for the specified update set and returns the result.

### EXAMPLE 2
```powershell
Start-SNOWUpdateSetCommit -sys_id "1234567890abcdef" | Wait-SNOWCICDProgress
```

Starts the commit process and waits for it to complete by piping the result to Wait-SNOWCICDProgress.

### EXAMPLE 3
```powershell
Get-SNOWUpdateSet -sys_id "1234567890abcdef" | Start-SNOWUpdateSetCommit | Wait-SNOWCICDProgress
```

Gets the update set, starts the commit process, and waits for it to complete.

## PARAMETERS

### -sys_id
The sys_id of the remote update set to be committed.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: remote_update_set_id

Required: True
Position: 1
Default value: None
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

