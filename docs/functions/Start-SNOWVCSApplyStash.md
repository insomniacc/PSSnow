---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Start-SNOWVCSApplyStash.md
schema: 2.0.0
---

# Start-SNOWVCSApplyStash

## SYNOPSIS
Starts applying a previously generated "stash" of changes from a remote source control.

## SYNTAX

```
Start-SNOWVCSApplyStash [-StashID] <String> [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This function calls the ServiceNow CICD API to start applying a previously generated "stash" of changes
from a remote source control to a specified local application or application-customization.

This function calls the ServiceNow API endpoint: api/sn_cicd/sc/apply_stash/{stash_id}

## EXAMPLES

### EXAMPLE 1
```powershell
Start-SNOWVCSApplyStash -StashID "fc2224e4e0429110f8771827f8fd3634"
```

Starts applying the specified stash.

### EXAMPLE 2
```powershell
Start-SNOWVCSApplyStash -StashID "fc2224e4e0429110f8771827f8fd3634" | Wait-SNOWCICDProgress
```

Starts applying the specified stash and waits for completion.

## PARAMETERS

### -StashID
Unique identifier of the stash to apply.
This value is returned in the links.stash.id parameter
in the corresponding GET /sn_cicd/progress/{progress_id} endpoint call.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

