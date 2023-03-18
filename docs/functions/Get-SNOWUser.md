---
external help file: PSServiceNow-help.xml
Module Name: PSServiceNow
online version: docs/functions/Get-SNOWUser.md
schema: 2.0.0
---

# Get-SNOWUser

## SYNOPSIS
Retrieves a servicenow user record

## SYNTAX

```
Get-SNOWUser [[-first_name] <String>] [[-last_name] <String>] [[-user_name] <String>]
 [[-employee_number] <String>] [[-email] <String>] [[-active] <Boolean>] [[-company] <String>]
 [[-department] <String>] [[-manager] <String>] [[-locked_out] <Boolean>] [-Sys_ID <String>] [-Query <String>]
 [-Fields <Array>] [-DisplayValue <String>] [-ExcludeReferenceLinks] [-Offset <Int32>] [-Limit <Int32>]
 [-RestrictDomain] [-SysParmView <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets a record from the sys_user table

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWUser -limit 1 -verbose
```

Returns a single user from the sys_user table

### EXAMPLE 2
```powershell
Get-SNOWUser -user_name 'bruce.wayne' -active $true
```

Returns any active user records with the username bruce.wayne

### EXAMPLE 3
```powershell
Get-SNOWUser -query 'first_name=bruce^last_name=wayne^active=true'
```

Returns any active user records with the name bruce wayne

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

### -last_name
{{ Fill last_name Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: LastName

Required: False
Position: 2
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
Position: 3
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
Position: 4
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
Position: 5
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
Position: 6
Default value: False
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
Position: 7
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
Position: 8
Default value: None
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
Position: 9
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
Position: 10
Default value: False
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

String. Any servicenow object with a sys_id property.
## OUTPUTS

PSCustomObject. The full table record/s.
## NOTES
Uses Get-SNOWObject as a template function.

## RELATED LINKS

[https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWUser.md](https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWUser.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


