---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Sync-SNOWDevStudioApp.md
schema: 2.0.0
---

# Sync-SNOWDevStudioApp

## SYNOPSIS
Imports, syncs and updates a ServiceNow application with a Git repository.
Use sn_devstudio API endpoints to manage the repository.

## SYNTAX

```
Sync-SNOWDevStudioApp [-ScopeName] <String> [-AppName] <String> [-RepoUri] <String>
 [-Credential] <PSCredential> [-Branch] <String> [-DefaultUser] <String> [-ApplyRemoteChanges] [-Force]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function synchronizes a ServiceNow application with a Git repository
by setting up the VCS integration and managing branch synchronization.
This function uses the ServiceNow Dev Studio API - which is the same API that SN Studio uses when managing a repository.
This function still works in some fringe cases where an application exists but the repo does not.

## EXAMPLES

### EXAMPLE 1
```powershell
Sync-SNOWDevStudioApp -ScopeName "x_acme_app" -AppName "ACME App" -RepoUri "https://github.com/org/repo.git" -Credential $cred -Branch "main" -DefaultUser "user@example.com"
```

## PARAMETERS

### -ScopeName
The scope name of the ServiceNow application.

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

### -AppName
The name of the ServiceNow application.

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

### -RepoUri
The URI of the Git repository.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
The credentials used to access the Git repository.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Branch
The Git branch to synchronize with.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultUser
The default user email to use for Git operations.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplyRemoteChanges
If specified, applies remote changes to the local instance.

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

### -Force
If specified, forces operations even if local changes exist.

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
This function requires an authenticated session to ServiceNow.

## RELATED LINKS

