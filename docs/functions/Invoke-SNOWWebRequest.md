---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Invoke-SNOWWebRequest.md
schema: 2.0.0
---

# Invoke-SNOWWebRequest

## SYNOPSIS
A generic way to make rest calls to servicenow API's

## SYNTAX

```
Invoke-SNOWWebRequest [-URI] <String> [[-Method] <String>] [[-Headers] <Hashtable>] [[-Body] <Object>]
 [[-ContentType] <String>] [[-OutFile] <String>] [[-InFile] <String>] [[-TransferEncoding] <String>]
 [-PassThru] [[-WebCallTimeoutSeconds] <Int32>] [-UseRestMethod] [-SkipHeaderValidation]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
A wrapper for Invoke-WebRequest & RestMethod that leverages authentication set with Set-SNOWAuth, provides support for proxy auth and also handles rate limiting (if set with -HandleRateLimiting on Set-SNOWAuth).

## EXAMPLES

### EXAMPLE 1
```powershell
$Response = Invoke-SNOWWebRequest -UseRestMethod -uri "api/now/v2/table/sys_user?sysparm_limit=1"
```

### EXAMPLE 2
```powershell
$Body = @{first_name="john";last_name="smith"} | ConvertTo-json
$Headers = @{"Content-Type"="Application/Json"}
$Response = Invoke-SNOWWebRequest -UseRestMethod -uri "api/now/v2/table/sys_user" -Method "POST" -Body $Body -Headers $Headers
```

## PARAMETERS

### -URI
{{ Fill URI Description }}

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
Default value: Get
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
Position: 3
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
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentType
{{ Fill ContentType Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutFile
{{ Fill OutFile Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InFile
{{ Fill InFile Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TransferEncoding
{{ Fill TransferEncoding Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
{{ Fill PassThru Description }}

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

### -WebCallTimeoutSeconds
{{ Fill WebCallTimeoutSeconds Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: $Script:SNOWAuth.WebCallTimeoutSeconds
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseRestMethod
{{ Fill UseRestMethod Description }}

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

### -SkipHeaderValidation
{{ Fill SkipHeaderValidation Description }}

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

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Invoke-SNOWWebRequest.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Invoke-SNOWWebRequest.md)


