---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Invoke-SNOWBackgroundScript.md
schema: 2.0.0
---

# Invoke-SNOWBackgroundScript

## SYNOPSIS
Executes a background script in the ServiceNow instance.

## SYNTAX

```
Invoke-SNOWBackgroundScript [-ScriptContents] <String> [-Scope <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Executes a background script in the ServiceNow instance and returns the response.

## EXAMPLES

### EXAMPLE 1
```powershell
Invoke-SNOWBackgroundScript -ScriptContents 'gs.print("Hello World")'
```

### EXAMPLE 2
```powershell
Invoke-SNOWBackgroundScript -ScriptContents 'gs.print("App Scope Script")' -Scope 'x_myapp_scope'
```

## PARAMETERS

### -ScriptContents
The contents of the script to execute.

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

### -Scope
The scope in which to execute the script.
Default is 'global'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Global
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

