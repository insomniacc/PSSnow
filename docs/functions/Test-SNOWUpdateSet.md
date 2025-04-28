---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Test-SNOWUpdateSet.md
schema: 2.0.0
---

# Test-SNOWUpdateSet

## SYNOPSIS
Tests an update set XML file to determine if it contains an update set.

## SYNTAX

```
Test-SNOWUpdateSet [-Path] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function tests an update set XML file to determine if it contains an update set. 
The function uses XPath to search for the sys_remote_update_set element with an empty parent display_value.

## EXAMPLES

### EXAMPLE 1
```powershell
Test-SNOWUpdateSet -Path "C:\Temp\MyUpdateSet.xml"
```

## PARAMETERS

### -Path
The path to the update set XML file.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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

