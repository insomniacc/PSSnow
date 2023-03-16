---
external help file: PSServiceNow-help.xml
Module Name: PSServiceNow
online version: docs/functions/New-SNOWAttachment.md
schema: 2.0.0
---

# New-SNOWAttachment

## SYNOPSIS
Upload a file attachment to servicenow

## SYNTAX

```
New-SNOWAttachment [-File] <FileInfo> [-Sys_ID] <String> [-Sys_Class_Name] <String> [-PassThru]
 [[-AttachedFilename] <String>] [-AsBatchRequest] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uploads a file as an attachment to a table record

## EXAMPLES

### EXAMPLE 1
```powershell
$response  = Get-SNOWUser -user_name "bruce.wayne" | New-SNOWAttachment -file "C:\temp\test.txt" -PassThru
Write-Host "File attached: $($response.download_link)"
Attaches test.txt to the user_record for bruce.wayne and returns the download link.
```

## PARAMETERS

### -File
if($_ | Test-Path -PathType Leaf){
}else{
    Throw "Filepath cannot be a directory."
}

```yaml
Type: System.IO.FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sys_ID
The sys_id of the parent record to associate with the new attachment

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: SysID, table_sys_id

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Sys_Class_Name
The table associated with the parent record

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: table, table_name

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru
The newly created attachment record will be returned

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

### -AttachedFilename
Used to alter the filename passed to servicenow.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
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

## NOTES
System limitations on uploaded files, such as maximum file size and allowed attachment types are configured within ServiceNow.
Default max file size is 1024MB.

## RELATED LINKS

[https://developer.servicenow.com/dev.do#!/reference/api/tokyo/rest/c_AttachmentAPI](https://developer.servicenow.com/dev.do#!/reference/api/tokyo/rest/c_AttachmentAPI)


