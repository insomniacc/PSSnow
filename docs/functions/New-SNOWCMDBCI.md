---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/New-SNOWCMDBCI.md
schema: 2.0.0
---

# New-SNOWCMDBCI

## SYNOPSIS
Creates a cmdb_ci record in SNOW

## SYNTAX

```
New-SNOWCMDBCI [[-asset_tag] <String>] [[-assigned] <String>] [[-assigned_to] <String>]
 [[-assignment_group] <String>] [[-attestation_score] <String>] [[-attestation_status] <String>]
 [[-attested] <Boolean>] [[-attested_by] <String>] [[-attested_date] <String>] [[-attributes] <String>]
 [[-business_unit] <String>] [[-can_print] <Boolean>] [[-category] <String>] [[-change_control] <String>]
 [[-checked_in] <String>] [[-checked_out] <String>] [[-comments] <String>] [[-company] <String>]
 [[-correlation_id] <String>] [[-cost] <String>] [[-cost_cc] <String>] [[-cost_center] <String>]
 [[-delivery_date] <String>] [[-department] <String>] [[-discovery_source] <String>] [[-dns_domain] <String>]
 [[-due] <String>] [[-due_in] <String>] [[-duplicate_of] <String>] [[-environment] <String>]
 [[-fault_count] <String>] [[-first_discovered] <String>] [[-fqdn] <String>] [[-gl_account] <String>]
 [[-install_date] <String>] [[-install_status] <String>] [[-invoice_number] <String>] [[-ip_address] <String>]
 [[-justification] <String>] [[-last_discovered] <String>] [[-lease_id] <String>]
 [[-life_cycle_stage] <String>] [[-life_cycle_stage_status] <String>] [[-location] <String>]
 [[-mac_address] <String>] [[-maintenance_schedule] <String>] [[-managed_by] <String>]
 [[-managed_by_group] <String>] [[-manufacturer] <String>] [[-model_id] <String>] [[-model_number] <String>]
 [[-monitor] <Boolean>] [[-name] <String>] [[-operational_status] <String>] [[-order_date] <String>]
 [[-owned_by] <String>] [[-po_number] <String>] [[-purchase_date] <String>] [[-schedule] <String>]
 [[-serial_number] <String>] [[-short_description] <String>] [[-start_date] <String>] [[-subcategory] <String>]
 [[-supported_by] <String>] [[-support_group] <String>] [[-vendor] <String>] [[-warranty_expiration] <String>]
 [-WhatIf] [-Confirm] [-Properties <Hashtable>] [-InputDisplayValue] [-PassThru] [-AsBatchRequest]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a record in the cmdb_ci table

## EXAMPLES

### EXAMPLE 1
```powershell
"="<value>"} -PassThru
Creates a single record in cmdb_ci and returns the new record with SysID
```

## PARAMETERS

### -asset_tag
{{ Fill asset_tag Description }}

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

### -assigned
{{ Fill assigned Description }}

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

### -assigned_to
{{ Fill assigned_to Description }}

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

### -assignment_group
{{ Fill assignment_group Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: change_group

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -attestation_score
{{ Fill attestation_score Description }}

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

### -attestation_status
{{ Fill attestation_status Description }}

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

### -attested
{{ Fill attested Description }}

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

### -attested_by
{{ Fill attested_by Description }}

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

### -attested_date
{{ Fill attested_date Description }}

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

### -attributes
{{ Fill attributes Description }}

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

### -business_unit
{{ Fill business_unit Description }}

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

### -can_print
{{ Fill can_print Description }}

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

### -category
{{ Fill category Description }}

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

### -change_control
{{ Fill change_control Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: approval_group

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -checked_in
{{ Fill checked_in Description }}

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

### -checked_out
{{ Fill checked_out Description }}

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

### -comments
{{ Fill comments Description }}

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

### -company
{{ Fill company Description }}

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

### -correlation_id
{{ Fill correlation_id Description }}

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

### -cost
{{ Fill cost Description }}

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

### -cost_cc
{{ Fill cost_cc Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: cost_currency

Required: False
Position: 21
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
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -delivery_date
{{ Fill delivery_date Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: order_received

Required: False
Position: 23
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
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -discovery_source
{{ Fill discovery_source Description }}

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

### -dns_domain
{{ Fill dns_domain Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -due
{{ Fill due Description }}

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

### -due_in
{{ Fill due_in Description }}

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

### -duplicate_of
{{ Fill duplicate_of Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -environment
{{ Fill environment Description }}

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

### -fault_count
{{ Fill fault_count Description }}

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

### -first_discovered
{{ Fill first_discovered Description }}

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

### -fqdn
{{ Fill fqdn Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: fully_qualified_domain_name

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -gl_account
{{ Fill gl_account Description }}

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

### -install_date
{{ Fill install_date Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: installed

Required: False
Position: 35
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -install_status
{{ Fill install_status Description }}

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

### -invoice_number
{{ Fill invoice_number Description }}

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

### -ip_address
{{ Fill ip_address Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -justification
{{ Fill justification Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -last_discovered
{{ Fill last_discovered Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: most_recent_discovery

Required: False
Position: 40
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -lease_id
{{ Fill lease_id Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: lease_contract

Required: False
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -life_cycle_stage
{{ Fill life_cycle_stage Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 42
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -life_cycle_stage_status
{{ Fill life_cycle_stage_status Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 43
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
Position: 44
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mac_address
{{ Fill mac_address Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 45
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -maintenance_schedule
{{ Fill maintenance_schedule Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -managed_by
{{ Fill managed_by Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 47
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -managed_by_group
{{ Fill managed_by_group Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -manufacturer
{{ Fill manufacturer Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -model_id
{{ Fill model_id Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -model_number
{{ Fill model_number Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -monitor
{{ Fill monitor Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: False
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
Position: 53
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -operational_status
{{ Fill operational_status Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -order_date
{{ Fill order_date Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ordered

Required: False
Position: 55
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -owned_by
{{ Fill owned_by Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 56
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -po_number
{{ Fill po_number Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 57
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -purchase_date
{{ Fill purchase_date Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: purchased

Required: False
Position: 58
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
Position: 59
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serial_number
{{ Fill serial_number Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -short_description
{{ Fill short_description Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: description

Required: False
Position: 61
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -start_date
{{ Fill start_date Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 62
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -subcategory
{{ Fill subcategory Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 63
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -supported_by
{{ Fill supported_by Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 64
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -support_group
{{ Fill support_group Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 65
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vendor
{{ Fill vendor Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 66
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warranty_expiration
{{ Fill warranty_expiration Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 67
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

PSCustomObject. The full table record/s (-PassThru only).
## NOTES
Uses New-SNOWObject as a template function.

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWCMDBCI.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWCMDBCI.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


