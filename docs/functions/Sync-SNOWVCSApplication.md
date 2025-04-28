---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Sync-SNOWVCSApplication.md
schema: 2.0.0
---

# Sync-SNOWVCSApplication

## SYNOPSIS
Synchronizes a ServiceNow application with a Git repository using the CICD Source Control API.

## SYNTAX

### BySysID (Default)
```
Sync-SNOWVCSApplication -SysID <String> -RepoURL <String> [-BranchName <String>] -Credential <PSCredential>
 [-DefaultUser <String>] [-MIDServerSysID <String>] [-AutoUpgradeBaseApp <Boolean>] [-ImportIfMissing]
 [-ApplyChanges] [-Force] [-TimeoutSec <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ByScope
```
Sync-SNOWVCSApplication -Scope <String> -RepoURL <String> [-BranchName <String>] -Credential <PSCredential>
 [-DefaultUser <String>] [-MIDServerSysID <String>] [-AutoUpgradeBaseApp <Boolean>] [-ImportIfMissing]
 [-ApplyChanges] [-Force] [-TimeoutSec <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function synchronizes a ServiceNow application with a Git repository using the modern
Source Control APIs available in the ServiceNow CICD module.
It can import new applications
or apply changes to existing ones from source control repositories.

This function leverages the ServiceNow API endpoints under api/sn_cicd/sc/ paths.

## EXAMPLES

### EXAMPLE 1
```powershell
Sync-SNOWVCSApplication -Scope "x_acme_app" -RepoURL "https://github.com/org/repo.git" -BranchName "main" -Credential $cred -ApplyChanges
```

Applies changes from the main branch of the specified repository to the application with scope x_acme_app.

### EXAMPLE 2
```powershell
Sync-SNOWVCSApplication -SysID "043db024db737300a9a754e4dc961915" -RepoURL "https://github.com/org/repo.git" -BranchName "develop" -Credential $cred -DefaultUser "user@example.com" -ImportIfMissing
```

Imports the application from the develop branch if it doesn't exist in the instance.

## PARAMETERS

### -Scope
The scope name of the ServiceNow application, such as x_acme_app.
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
The sys_id of the ServiceNow application.
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

### -RepoURL
Required.
The URL of the Git repository.

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

### -BranchName
The Git branch to synchronize with.
Default is the default branch specified in the source control system.

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

### -Credential
The credentials used to access the Git repository.
Will be stored in ServiceNow as a basic_auth_credential record.

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MIDServerSysID
The sys_id of the MID server to use for source control operations.

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
Flag that indicates whether the system should auto-upgrade the base application to a later version.
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

### -ImportIfMissing
If specified, imports the application if it doesn't exist in the instance.

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

### -ApplyChanges
If specified, applies changes from the remote repository to the local instance.

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
If specified, forces operations even if conflicts might occur.

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

### -TimeoutSec
The maximum time in seconds to wait for operations to complete.
Default is 600 seconds (10 minutes).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 600
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
This function requires an authenticated session to ServiceNow with appropriate permissions for CICD operations.

## RELATED LINKS

