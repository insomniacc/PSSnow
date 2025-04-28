---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Start-SNOWVCSApplyChanges.md
schema: 2.0.0
---

# Start-SNOWVCSApplyChanges

## SYNOPSIS
Starts applying changes from a remote source control to a specified local application or application-customization.

## SYNTAX

### BySysID (Default)
```
Start-SNOWVCSApplyChanges -SysID <String> [-BranchName <String>] [-AutoUpgradeBaseApp <Boolean>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByScope
```
Start-SNOWVCSApplyChanges -Scope <String> [-BranchName <String>] [-AutoUpgradeBaseApp <Boolean>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This function calls the ServiceNow CICD API to start applying changes from a remote source control
repository to a specified local application or application-customization.

This function calls the ServiceNow API endpoint: api/sn_cicd/sc/apply_changes

## EXAMPLES

### EXAMPLE 1
```powershell
Start-SNOWVCSApplyChanges -Scope "x_aah_custom_app"
```

Starts applying changes from the default branch to the application with the specified scope.

### EXAMPLE 2
```powershell
Start-SNOWVCSApplyChanges -SysID "043db024db737300a9a754e4dc961915" -BranchName "develop" | Wait-SNOWCICDProgress
```

Starts applying changes from the "develop" branch to the application with the specified sys_id and waits for completion.

## PARAMETERS

### -Scope
The scope name of the application for which to apply the changes, such as x_aah_custom_app.
Required if SysID is not specified.

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

### -SysID
The sys_id of the application for which to apply the changes.
Required if Scope is not specified.

```yaml
Type: System.String
Parameter Sets: BySysID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BranchName
Name of the branch in the source control system from which to acquire the application.
Default is the default branch specified on the source control system.

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

### -AutoUpgradeBaseApp
Flag that indicates whether the system should auto upgrade the base application to a later version.
Only applicable when changes are applied for app-customization and the latest commit on the Git repository
is built on a version that is later than that of the base application that is currently installed on the local instance.
Default is true.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
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

