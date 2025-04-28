---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Import-SNOWUpdateSet.md
schema: 2.0.0
---

# Import-SNOWUpdateSet

## SYNOPSIS
Imports an update set XML file into ServiceNow using sys_upload.do and a valid WebSession.

## SYNTAX

```
Import-SNOWUpdateSet [-Path] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function imports an update set XML file into ServiceNow.
It first validates the update set
and then uploads it to the instance if it doesn't already exist.

This function calls the ServiceNow API endpoint: sys_upload.do

The function requires a valid web session, which can be established using the Connect-SNOW function.

## EXAMPLES

### EXAMPLE 1
```powershell
Import-SNOWUpdateSet -Path "C:\Temp\MyUpdateSet.xml"
```

Validates and imports the specified update set XML file into ServiceNow.

### EXAMPLE 2
```powershell
Get-ChildItem -Path "C:\Temp\UpdateSets\*.xml" | Import-SNOWUpdateSet
```

Imports all XML files in the specified directory that contain valid update sets.

### EXAMPLE 3
```powershell
Test-SNOWUpdateSet -Path "C:\Temp\MyUpdateSet.xml" | Import-SNOWUpdateSet
```

Tests if the file contains a valid update set and imports it if valid.

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

