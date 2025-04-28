---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Set-SNOWWebConcourseState.md
schema: 2.0.0
---

# Set-SNOWWebConcourseState

## SYNOPSIS
Sets the current application or update set in a ServiceNow web session.

## SYNTAX

### ScopeName (Default)
```
Set-SNOWWebConcourseState -ScopeName <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ApplicationId
```
Set-SNOWWebConcourseState -ApplicationId <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### UpdateSet
```
Set-SNOWWebConcourseState -UpdateSet <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function changes the current application or update set in an active ServiceNow web session.
It uses the ServiceNow Concourse Picker API to switch the context of the session.

## EXAMPLES

### EXAMPLE 1
```powershell
Set-SNOWWebConcourseState -ScopeName "global"
```

Sets the current application to 'global' using the scope name.

### EXAMPLE 2
```powershell
Set-SNOWWebConcourseState -ApplicationId "2329f897dbdcab00d5c07109af9619a2"
```

Sets the current application using its sys_id.

### EXAMPLE 3
```powershell
Set-SNOWWebConcourseState -UpdateSet "9a4b095f87902110929c6d73cebb3598"
```

Sets the current update set to the one with the specified sys_id.

## PARAMETERS

### -ApplicationId
The sys_id of the application to set as the current application.
This parameter is part of the 'ApplicationId' parameter set.

```yaml
Type: System.String
Parameter Sets: ApplicationId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScopeName
The scope name of the application to set as the current application.
This parameter is part of the 'ScopeName' parameter set.

```yaml
Type: System.String
Parameter Sets: ScopeName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdateSet
The sys_id of the update set to set as the current update set.
This parameter is part of the 'UpdateSet' parameter set.

```yaml
Type: System.String
Parameter Sets: UpdateSet
Aliases:

Required: True
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

Returns the updated concourse state after the operation.
## NOTES
This function should be used in conjunction with a valid ServiceNow web session.
(See: Set-SNOWAuth -UseWebSession)
Using without a session should be done with caution if the user account is logged in elsewhere.

## RELATED LINKS

