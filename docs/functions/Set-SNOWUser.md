---
external help file: PSServiceNow-help.xml
Module Name: PSServiceNow
online version: docs/functions/Set-SNOWUser.md
schema: 2.0.0
---

# Set-SNOWUser

## SYNOPSIS
Updates a new servicenow user record

## SYNTAX

```
Set-SNOWUser [[-first_name] <String>] [[-last_name] <String>] [[-middle_name] <String>] [[-user_name] <String>]
 [[-employee_number] <String>] [[-email] <String>] [[-active] <Boolean>] [[-Company] <String>]
 [[-Department] <String>] [[-Manager] <String>] [[-locked_out] <Boolean>] [[-user_password] <String>] [-WhatIf]
 [-Confirm] -Sys_ID <String> [-Properties <Hashtable>] [-InputDisplayValue] [-PassThru] [-AsBatchRequest]
 [<CommonParameters>]
```

## DESCRIPTION
Updates a record in the sys_user table

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWUser -user_name 'Bruce.Wayne' -active $true | Set-SNOWUser -middle_name "Thomas"
```

Updates the middle_name of the user record bruce.wayne in the sys_user table

### EXAMPLE 2
```powershell
Set-SNOWUser -middle_name "Thomas" -sys_id 02826bf03710200044e0bfc8bcbe5d3f
```

Updates the middle_name of the user record bruce.wayne in the sys_user table

## PARAMETERS

### -first_name
{{ Fill first_name Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -last_name
{{ Fill last_name Description }}

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

### -middle_name
{{ Fill middle_name Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -user_name
{{ Fill user_name Description }}

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

### -employee_number
{{ Fill employee_number Description }}

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

### -email
{{ Fill email Description }}

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

### -active
{{ Fill active Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Company
{{ Fill Company Description }}

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

### -Department
{{ Fill Department Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Manager
{{ Fill Manager Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -locked_out
{{ Fill locked_out Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -user_password
{{ Fill user_password Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
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

### -AsBatchRequest
{{ Fill AsBatchRequest Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputDisplayValue
{{ Fill InputDisplayValue Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
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
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Properties
{{ Fill Properties Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sys_ID
{{ Fill Sys_ID Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

PSCustomObject. The full table record (requires -PassThru).
## NOTES

## RELATED LINKS

[https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Set-SNOWUser.md](https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Set-SNOWUser.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


