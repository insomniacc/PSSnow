---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Get-SNOWUser.md
schema: 2.0.0
---

# Get-SNOWUser

## SYNOPSIS
Retrieves a sys_user record from SNOW

## SYNTAX

```
Get-SNOWUser [[-active] <Boolean>] [[-building] <String>] [[-city] <String>] [[-company] <String>]
 [[-cost_center] <String>] [[-country] <String>] [[-department] <String>] [[-email] <String>]
 [[-employee_number] <String>] [[-enable_multifactor_authn] <Boolean>] [[-failed_attempts] <String>]
 [[-first_name] <String>] [[-gender] <String>] [[-home_phone] <String>]
 [[-internal_integration_user] <Boolean>] [[-introduction] <String>] [[-last_name] <String>]
 [[-ldap_server] <String>] [[-location] <String>] [[-locked_out] <Boolean>] [[-manager] <String>]
 [[-middle_name] <String>] [[-mobile_phone] <String>] [[-name] <String>] [[-notification] <String>]
 [[-password_needs_reset] <Boolean>] [[-phone] <String>] [[-photo] <String>] [[-preferred_language] <String>]
 [[-roles] <String>] [[-schedule] <String>] [[-source] <String>] [[-state] <String>] [[-street] <String>]
 [[-time_format] <String>] [[-time_zone] <String>] [[-title] <String>] [[-user_name] <String>]
 [[-vip] <Boolean>] [[-web_service_access_only] <Boolean>] [[-zip] <String>] [-Sys_ID <String>]
 [-Query <String>] [-Fields <Array>] [-DisplayValue <String>] [-ExcludeReferenceLinks] [-Offset <Int32>]
 [-Limit <Int32>] [-RestrictDomain] [-SysParmView <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets a record from the sys_user table

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWUser -limit 1 -verbose
Returns a single record from sys_user
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

### -failed_attempts
{{ Fill failed_attempts Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: failed_login_attempts

Required: False
Position: 11
Default value: None
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
Position: 12
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
Position: 13
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
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -internal_integration_user
{{ Fill internal_integration_user Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: False
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
Position: 16
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
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ldap_server
{{ Fill ldap_server Description }}

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

### -location
{{ Fill location Description }}

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

### -locked_out
{{ Fill locked_out Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
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
Position: 21
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
Position: 22
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
Position: 23
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
Position: 24
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
Position: 25
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
Position: 26
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
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -photo
{{ Fill photo Description }}

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

### -preferred_language
{{ Fill preferred_language Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: language

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -roles
{{ Fill roles Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -schedule
{{ Fill schedule Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -source
{{ Fill source Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -state
{{ Fill state Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: state___province

Required: False
Position: 33
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
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -time_format
{{ Fill time_format Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
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
Position: 36
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
Position: 37
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
Position: 38
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
Position: 39
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
Position: 40
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
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayValue
{{ Fill DisplayValue Description }}

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

### -ExcludeReferenceLinks
{{ Fill ExcludeReferenceLinks Description }}

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

### -Fields
{{ Fill Fields Description }}

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit
{{ Fill Limit Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Offset
{{ Fill Offset Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Query
{{ Fill Query Description }}

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

### -RestrictDomain
{{ Fill RestrictDomain Description }}

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

### -Sys_ID
{{ Fill Sys_ID Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: SysID

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SysParmView
{{ Fill SysParmView Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

PSCustomObject. The full table record/s.
## NOTES
Uses Get-SNOWObject as a template function.

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWUser.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWUser.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


