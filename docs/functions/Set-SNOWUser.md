---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Set-SNOWUser.md
schema: 2.0.0
---

# Set-SNOWUser

## SYNOPSIS
Updates a sys_user record in SNOW

## SYNTAX

```
Set-SNOWUser [[-active] <Boolean>] [[-building] <String>] [[-city] <String>] [[-company] <String>]
 [[-cost_center] <String>] [[-country] <String>] [[-department] <String>] [[-email] <String>]
 [[-employee_number] <String>] [[-enable_multifactor_authn] <Boolean>] [[-first_name] <String>]
 [[-gender] <String>] [[-home_phone] <String>] [[-introduction] <String>] [[-last_name] <String>]
 [[-location] <String>] [[-locked_out] <Boolean>] [[-manager] <String>] [[-middle_name] <String>]
 [[-mobile_phone] <String>] [[-name] <String>] [[-notification] <String>] [[-password_needs_reset] <Boolean>]
 [[-phone] <String>] [[-preferred_language] <String>] [[-state] <String>] [[-street] <String>]
 [[-title] <String>] [[-user_name] <String>] [[-user_password] <String>] [[-vip] <Boolean>]
 [[-web_service_access_only] <Boolean>] [[-zip] <String>] [-WhatIf] [-Confirm] -Sys_ID <String>
 [-Properties <Hashtable>] [-InputDisplayValue] [-PassThru] [-AsBatchRequest] [<CommonParameters>]
```

## DESCRIPTION
Updates a record from the sys_user table

## EXAMPLES

### EXAMPLE 1
```powershell
" -Properties @{"<key>"="<value>"} -verbose
Updates a specific record in the table sys_user
```

## PARAMETERS

### -active
{{ Fill active Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -building
{{ Fill building Description }}

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

### -city
{{ Fill city Description }}

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

### -company
{{ Fill company Description }}

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

### -cost_center
{{ Fill cost_center Description }}

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

### -country
{{ Fill country Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: country_code

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -department
{{ Fill department Description }}

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

### -email
{{ Fill email Description }}

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

### -employee_number
{{ Fill employee_number Description }}

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

### -enable_multifactor_authn
{{ Fill enable_multifactor_authn Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: enable_multifactor_authentication

Required: False
Position: 10
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -first_name
{{ Fill first_name Description }}

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

### -gender
{{ Fill gender Description }}

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

### -home_phone
{{ Fill home_phone Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -introduction
{{ Fill introduction Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: prefix

Required: False
Position: 14
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
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -location
{{ Fill location Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
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
Position: 17
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -manager
{{ Fill manager Description }}

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

### -middle_name
{{ Fill middle_name Description }}

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

### -mobile_phone
{{ Fill mobile_phone Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
{{ Fill name Description }}

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

### -notification
{{ Fill notification Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
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
Position: 23
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
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -preferred_language
{{ Fill preferred_language Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: language

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -state
{{ Fill state Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: province

Required: False
Position: 26
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
Position: 27
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
Position: 28
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -user_name
{{ Fill user_name Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: user_id

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -user_password
{{ Fill user_password Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: password

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vip
{{ Fill vip Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
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
Position: 32
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -zip
{{ Fill zip Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: zip___postal_code

Required: False
Position: 33
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

PSCustomObject. The full table record/s (-PassThru only).
## NOTES
Uses Set-SNOWObject as a template function.

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWUser.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWUser.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


