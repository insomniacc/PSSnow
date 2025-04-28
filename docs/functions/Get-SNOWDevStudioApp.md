---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Get-SNOWDevStudioApp.md
schema: 2.0.0
---

# Get-SNOWDevStudioApp

## SYNOPSIS
Get all VCS apps from api/sn_devstudio/v1/vcs/apps

## SYNTAX

```
Get-SNOWDevStudioApp [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function retrieves VCS-enabled applications from ServiceNow DevStudio.
It calls the ServiceNow API endpoint: api/sn_devstudio/v1/vcs/apps

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWDevStudioApp
Returns all VCS-enabled applications in the ServiceNow instance.
```

### EXAMPLE 2
```powershell
$apps = Get-SNOWDevStudioApp
$apps | Select-Object name, id, version
Retrieves VCS apps and displays selected properties.
```

## PARAMETERS

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
Requires an active ServiceNow connection configured with Set-SNOWAuth.

## RELATED LINKS

