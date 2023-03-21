---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Remove-SNOWAttachment.md
schema: 2.0.0
---

# Remove-SNOWAttachment

## SYNOPSIS
Removes attachments from servicenow.

## SYNTAX

```
Remove-SNOWAttachment [-Sys_ID] <String> [[-file_name] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes an attachment from servicenow.

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-SNOWAttachment -Sys_ID a73f6d2447292110d3e5fa8bd36d4304
```

Removes a single attachment by sys_id

### EXAMPLE 2
```powershell
Get-SNOWUser -user_name "bruce.wayne" | Get-SNOWAttachment | Remove-SNOWAttachment -Verbose
```

Removes all attachments on the associated parent object

## PARAMETERS

### -Sys_ID
The SysID of the attachment record to be deleted

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -file_name
{{ Fill file_name Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
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

## NOTES

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Remove-SNOWAttachment.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Remove-SNOWAttachment.md)

[https://docs.servicenow.com/csh?topicname=c_AttachmentAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_AttachmentAPI.html&version=latest)


