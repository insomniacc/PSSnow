---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Invoke-SNOWRestMethod.md
schema: 2.0.0
---

# Invoke-SNOWRestMethod

## SYNOPSIS
A generic way to make rest calls to servicenow API's \[deprecated\]

## SYNTAX

```
Invoke-SNOWRestMethod [-Uri] <String> [[-Method] <String>] [[-Body] <Object>] [[-Headers] <Hashtable>]
 [<CommonParameters>]
```

## DESCRIPTION
A wrapper for Invoke-RestMethod that utilizes authentication set with Set-SNOWAuth \[deprecated\]

## EXAMPLES

### EXAMPLE 1
```powershell
$Response = Invoke-SNOWRestMethod -uri "api/now/v2/table/sys_user?sysparm_limit=1"
```

### EXAMPLE 2
```powershell
$Body = @{first_name="john";last_name="smith"} | ConvertTo-json
$Headers = @{"Content-Type"="Application/Json"}
$Response = Invoke-SNOWRestMethod -uri "api/now/v2/table/sys_user" -Method "POST" -Body $Body -Headers $Headers
```

## PARAMETERS

### -Uri
{{ Fill Uri Description }}

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

### -Method
{{ Fill Method Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Body
{{ Fill Body Description }}

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Headers
{{ Fill Headers Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
!This function is deprecated and has been left in for backward compatibility.
Please use Invoke-SNOWWebRequest instead.

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Invoke-SNOWRestMethod.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Invoke-SNOWRestMethod.md)


