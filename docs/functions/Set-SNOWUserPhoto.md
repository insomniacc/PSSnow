---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Set-SNOWUserPhoto.md
schema: 2.0.0
---

# Set-SNOWUserPhoto

## SYNOPSIS
Attaches a picture to a user record and updates the photo property

## SYNTAX

```
Set-SNOWUserPhoto -Filepath <FileInfo> -Sys_ID <String> [-PassThru] [-AsBatchRequest] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This function uses the Attachment API to upload a photo to a user record as a hidden attachment

## EXAMPLES

### EXAMPLE 1
```powershell
$User | Set-SNOWUserPhoto -filepath "C:\Temp\Bruce.jpg"
```

Updates a user photo

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
Accept pipeline input: True (ByPropertyName)
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

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWUserPhoto.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWUserPhoto.md)

[https://docs.servicenow.com/csh?topicname=c_AttachmentAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_AttachmentAPI.html&version=latest)


