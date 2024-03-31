---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Set-SNOWRITMVariable.md
schema: 2.0.0
---

# Set-SNOWRITMVariable

## SYNOPSIS
Set the value of a variable associated with a RITM

## SYNTAX

### sys_id (Default)
```
Set-SNOWRITMVariable -Sys_Id <String> -Name <String> -Value <String> [-ProgressAction <ActionPreference>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### number
```
Set-SNOWRITMVariable -Number <String> -Name <String> -Value <String> [-ProgressAction <ActionPreference>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the value of a variable in the sc_item_option table

## EXAMPLES

### EXAMPLE 1
```powershell
Set-SNOWRITMVariable -Sys_id "a07e6bd947616110d3e5fa8bd36d4339" -Name "business_purpose" -Value "Hello World"
Sets the value of business_purpose on a RITM with the sys_id of 'a07e6bd947616110d3e5fa8bd36d4339' to 'Hello World'
```

### EXAMPLE 2
```powershell
Set-SNOWRITMVariable -Number "RITM0010001" -Name "business_purpose" -Value "Hello World"
Sets the value of business_purpose on RITM00100001 to 'Hello World'
```

### EXAMPLE 3
```powershell
Get-SNOWSCRequestedItem -number "RITM00100001" | Set-SNOWRITMVariable -Name "business_purpose" -Value "Hello World"
Sets the value of business_purpose on RITM00100001 to 'Hello World'
```

## PARAMETERS

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

### -Name
{{ Fill Name Description }}

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

### -Value
{{ Fill Value Description }}

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

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWRITMVariable.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWRITMVariable.md)


