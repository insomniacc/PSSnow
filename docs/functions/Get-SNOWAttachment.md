---
external help file: PSServiceNow-help.xml
Module Name: PSServiceNow
online version: docs/functions/Get-SNOWAttachment.md
schema: 2.0.0
---

# Get-SNOWAttachment

## SYNOPSIS
Gets attachments from servicenow.

## SYNTAX

### Attachment
```
Get-SNOWAttachment -Sys_ID <String> [-PassThru] [-OutputDestination <String>] [-OutputFilename <String>]
 [-Force] [-DisregardSourceTable] [<CommonParameters>]
```

### SNOWObject
```
Get-SNOWAttachment -SNOWObject <PSObject> [-Offset <Int32>] [-Limit <Int32>] [-PassThru]
 [-OutputDestination <String>] [-OutputFilename <String>] [-Force] [-PaginationAmount <Int32>]
 [-DisregardSourceTable] [<CommonParameters>]
```

### Query
```
Get-SNOWAttachment -Query <String> [-Offset <Int32>] [-Limit <Int32>] [-PassThru] [-OutputDestination <String>]
 [-OutputFilename <String>] [-Force] [-PaginationAmount <Int32>] [-DisregardSourceTable] [<CommonParameters>]
```

## DESCRIPTION
Retrieves attachment records or binary data from either a direct lookup, parent object or query.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWAttachment -Sys_ID a73f6d2447292110d3e5fa8bd36d4304
```

Provide the sys_id of an attachment to look it up directly

### EXAMPLE 2
```powershell
Get-SNOWAttachment -Sys_ID a73f6d2447292110d3e5fa8bd36d4304 -PassThru
```

Downloads and returns the binary data for the attachment

### EXAMPLE 3
```powershell
Get-SNOWAttachment -Sys_ID a73f6d2447292110d3e5fa8bd36d4304 -PassThru -OutputDestination "c:\temp"
```

Downloads and saves the attachment into the specified destination folder with the original filename

### EXAMPLE 4
```powershell
Get-SNOWAttachment -Sys_ID a73f6d2447292110d3e5fa8bd36d4304 -PassThru -OutputDestination "c:\temp" -OutputFilename "NewFilename.jpg"
```

Downloads and saves the attachment into the specified destination with a different filename.

### EXAMPLE 5
```powershell
Get-SNOWUser -user_name "bruce.wayne" | Get-SNOWAttachment -PassThru -OutputDestination "c:\temp"
```

Pipe any Get-SNOW* table command to get all the associated attachments and save them into the output destination

### EXAMPLE 6
```powershell
Get-SNOWUser -user_name "bruce.wayne" | Get-SNOWAttachment
```

Pipe any Get-SNOW* table command to get all the associated attachment records

## PARAMETERS

### -Sys_ID
{{ Fill Sys_ID Description }}

```yaml
Type: System.String
Parameter Sets: Attachment
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SNOWObject
{{ Fill SNOWObject Description }}

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: SNOWObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Query
Can be copied directly from the snow web gui

```yaml
Type: System.String
Parameter Sets: Query
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Offset
{{ Fill Offset Description }}

```yaml
Type: System.Int32
Parameter Sets: SNOWObject, Query
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit
{{ Fill Limit Description }}

```yaml
Type: System.Int32
Parameter Sets: SNOWObject, Query
Aliases:

Required: False
Position: Named
Default value: 0
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

### -OutputDestination
{{ Fill OutputDestination Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputFilename
{{ Fill OutputFilename Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
{{ Fill Force Description }}

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

### -PaginationAmount
{{ Fill PaginationAmount Description }}

```yaml
Type: System.Int32
Parameter Sets: SNOWObject, Query
Aliases:

Required: False
Position: Named
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisregardSourceTable
{{ Fill DisregardSourceTable Description }}

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
System limitations on uploaded files, such as maximum file size and allowed attachment types are configured within ServiceNow.
Default max file size is 1024MB.

## RELATED LINKS

[https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWAttachment.md](https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWAttachment.md)

[https://docs.servicenow.com/csh?topicname=c_AttachmentAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_AttachmentAPI.html&version=latest)


