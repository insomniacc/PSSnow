---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Get-SNOWRITMVariableSet.md
schema: 2.0.0
---

# Get-SNOWRITMVariableSet

## SYNOPSIS
Gets all associated variables for a RITM

## SYNTAX

### sys_id (Default)
```
Get-SNOWRITMVariableSet -Sys_Id <String> [-IncludeLabels] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### number
```
Get-SNOWRITMVariableSet -Number <String> [-IncludeLabels] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns all the RITM variables and display labels

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWRITMVariableSet -number "RITM0010001"
Returns RITM Variables for RITM0010001
```

### EXAMPLE 2
```powershell
Get-SNOWRITMVariableSet -Sys_id a07e6bd947616110d3e5fa8bd36d4339
Returns RITM Variables for the RITM with a sys_id of a07e6bd947616110d3e5fa8bd36d4339
```

### EXAMPLE 3
```powershell
Get-SNOWRITMVariableSet -number "RITM0010001" -IncludeLabels
Returns RITM Variables for RITM0010001, adding the display label to the output object
```

### EXAMPLE 4
```powershell
Get-SNOWSCRequestedItem -Number "RITM0010001" | Get-SNOWRITMVariableSet
Returns RITM Variables for RITM0010001
```

## PARAMETERS

### -Number
{{ Fill Number Description }}

```yaml
Type: System.String
Parameter Sets: number
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Sys_Id
{{ Fill Sys_Id Description }}

```yaml
Type: System.String
Parameter Sets: sys_id
Aliases: sysid

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeLabels
{{ Fill IncludeLabels Description }}

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

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWRITMVariableSet.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWRITMVariableSet.md)


