---
external help file: PSServiceNow-help.xml
Module Name: PSServiceNow
online version: docs/functions/Set-SNOWUserPhoto.md
schema: 2.0.0
---

# Set-SNOWUserPhoto

## SYNOPSIS
Creates a photo attachment for a user record and sets the photo property on that user

## SYNTAX

```
Set-SNOWUserPhoto -Filepath <FileInfo> -Sys_ID <String> [-PassThru] [-AsBatchRequest] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Using the ecc_queue table and the AttachmentCreator topic, a photo/image is associated to a user record

## EXAMPLES

### EXAMPLE 1
```powershell
New-SNOWUserPhoto -sysID "70c008e047a12110d3e5fa8bd36d436f" -filepath "C:\Users\Insomniac\Desktop\Bruce.jpg"
Creates a new user called bruce wayne in the sys_user table
```

## PARAMETERS

### -Filepath
{{ Fill Filepath Description }}

```yaml
Type: System.IO.FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sys_ID
The sys_id of the user record in the sys_user table

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: SysID

Required: True
Position: Named
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

### -AsBatchRequest
{{ Fill AsBatchRequest Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

PSCustomObject. The full table record (requires -PassThru).
## NOTES

## RELATED LINKS

[https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html](https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html)


