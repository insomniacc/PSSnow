---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Start-SNOWUpdateSetBackOut.md
schema: 2.0.0
---

# Start-SNOWUpdateSetBackOut

## SYNOPSIS
Removes (backs out) an update set from ServiceNow.

## SYNTAX

```
Start-SNOWUpdateSetBackOut [-Sys_ID] <String> [[-RollbackInstalls] <Boolean>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This function backs out an update set from ServiceNow using the CICD API.
It returns the raw result object from the API which can be piped to Wait-SNOWCICDProgress
to wait for the operation to complete.

This function calls the ServiceNow API endpoint: api/sn_cicd/update_set/back_out

## EXAMPLES

### EXAMPLE 1
```powershell
Start-SNOWUpdateSetBackOut -sys_id "1234567890abcdef"
```

Backs out the specified update set and returns the result object.

### EXAMPLE 2
```powershell
Start-SNOWUpdateSetBackOut -sys_id "1234567890abcdef" -RollbackInstalls $true
```

Backs out the update set and rolls back any batch installations.

### EXAMPLE 3
```powershell
Start-SNOWUpdateSetBackOut -sys_id "1234567890abcdef" | Wait-SNOWCICDProgress
```

Backs out the update set and waits for the process to complete.

## PARAMETERS

### -Sys_ID
The sys_id of the update set to be backed out.

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

### -RollbackInstalls
If specified, any batch installations performed during the update set commit will be rolled back.
Default is false.

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

