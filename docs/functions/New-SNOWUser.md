---
external help file: PSServiceNow-help.xml
Module Name: PSServiceNow
online version: docs/functions/New-SNOWUser.md
schema: 2.0.0
---

# New-SNOWUser

## SYNOPSIS
Creates a new servicenow user record

## SYNTAX

```
New-SNOWUser [[-first_name] <String>] [[-middle_name] <String>] [[-last_name] <String>] [[-user_name] <String>]
 [[-employee_number] <String>] [[-email] <String>] [[-active] <Boolean>] [[-locked_out] <Boolean>]
 [[-Company] <String>] [[-Department] <String>] [[-Manager] <String>] [[-enable_multifactor_authn] <Boolean>]
 [[-web_service_access_only] <Boolean>] [[-phone] <String>] [[-mobile_phone] <String>]
 [[-password_needs_reset] <Boolean>] [[-city] <String>] [[-title] <String>] [[-street] <String>]
 [[-photo] <FileInfo>] [[-time_zone] <String>] [[-preferred_language] <String>] [-WhatIf] [-Confirm]
 [-Properties <Hashtable>] [-InputDisplayValue] [-PassThru] [-AsBatchRequest] [<CommonParameters>]
```

## DESCRIPTION
Creates a record in the sys_user table

## EXAMPLES

### EXAMPLE 1
```powershell
$Properties = @{
    user_name = "bruce.wayne"
    title = "Director"
    first_name = "Bruce"
    last_name = "Wayne"
    department = "Finance"
    email = "Bruce@WayneIndustries.com"
}
New-SNOWUser @Properties -PassThru
Creates a new user called bruce wayne in the sys_user table
```

## PARAMETERS

### -first_name
{{ Fill first_name Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: FirstName

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -middle_name
{{ Fill middle_name Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: MiddleName

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -last_name
{{ Fill last_name Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: LastName

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
Aliases: Username

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
Aliases: EmployeeNumber

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

### -locked_out
{{ Fill locked_out Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
Position: 9
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
Position: 10
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
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -enable_multifactor_authn
{{ Fill enable_multifactor_authn Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -web_service_access_only
{{ Fill web_service_access_only Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -phone
{{ Fill phone Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: business_phone

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobile_phone
{{ Fill mobile_phone Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -password_needs_reset
{{ Fill password_needs_reset Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -city
{{ Fill city Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -title
{{ Fill title Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -street
{{ Fill street Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -photo
{{ Fill photo Description }}

```yaml
Type: System.IO.FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -time_zone
{{ Fill time_zone Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -preferred_language
{{ Fill preferred_language Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: Language

Required: False
Position: 22
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

PSCustomObject. The full table record (requires -PassThru).
## NOTES

## RELATED LINKS

[https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html](https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html)


