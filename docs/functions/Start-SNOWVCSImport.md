---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Start-SNOWVCSImport.md
schema: 2.0.0
---

# Start-SNOWVCSImport

## SYNOPSIS
Imports an application using the specified repository URL and branch name.

## SYNTAX

```
Start-SNOWVCSImport [-RepoURL] <String> [-BranchName] <String> [[-CredentialSysID] <String>]
 [[-MIDServerSysID] <String>] [[-AutoUpgradeBaseApp] <Boolean>] [[-TransactionScope] <String>]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This function calls the ServiceNow CICD API to import an application from source control in the calling instance.
This allows you to use Continuous Integration and Continuous Delivery (CICD) endpoints to deploy the
application to upper environments.

This function calls the ServiceNow API endpoint: api/sn_cicd/sc/import

## EXAMPLES

### EXAMPLE 1
```powershell
Start-SNOWVCSImport -RepoURL "https://github.com/user/repo.git" -BranchName "main"
```

Imports an application from the specified repository and branch.

### EXAMPLE 2
```powershell
Start-SNOWVCSImport -RepoURL "https://github.com/user/repo.git" -BranchName "develop" -CredentialSysID "af9b6d6180feb010f8779c30d4dd6b6b" | Wait-SNOWCICDProgress
```

Imports an application from the specified repository and branch using specific credentials and waits for completion.

## PARAMETERS

### -RepoURL
Required.
URL of the Git repository to import the application from.

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

### -BranchName
Required.
Name of the branch in the source control system to import the application from.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CredentialSysID
Sys_id of the credentials that have access to the Git repository.
Default is the sys_id set in the system properties.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MIDServerSysID
Sys_id of the MID server to use for source control operations for this application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoUpgradeBaseApp
Flag that indicates whether the system should auto-upgrade the base application to a later version.
Only applicable when the application being imported is an app-customization and the latest commit on
the Git repository is built on a version that is later than that of the base application.
Default is true.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -TransactionScope
The scope of the transaction to be used for the import.
This is optional and can be set to a specific scope.
Default is the current scope of the calling instance.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: Global
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

