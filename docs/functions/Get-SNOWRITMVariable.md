---
external help file: PSServiceNow-help.xml
Module Name: PSServiceNow
online version: docs/functions/Get-SNOWRITMVariable.md
schema: 2.0.0
---

# Get-SNOWRITMVariable

## SYNOPSIS
Gets all associated variables for a RITM

## SYNTAX

### number
```
Get-SNOWRITMVariable -Number <String> [-IncludeLabels] [<CommonParameters>]
```

### sys_id
```
Get-SNOWRITMVariable -Sys_Id <String> [-IncludeLabels] [<CommonParameters>]
```

## DESCRIPTION
Returns all the RITM variables and display labels

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWRITMVariable -number "RITM0010001"
```

Returns RITM Variables for RITM0010001

### EXAMPLE 2
```powershell
Get-SNOWRITMVariable -number "RITM0010001" -IncludeLabels
```

Returns RITM Variables for RITM0010001, adding the display label to the output object

### EXAMPLE 3
```powershell
Get-SNOWSCRequestedItem -Number "RITM0010001" | Get-SNOWRITMVariable
```

Returns RITM Variables for RITM0010001

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
Accept pipeline input: False
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWRITMVariable.md](https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWRITMVariable.md)


