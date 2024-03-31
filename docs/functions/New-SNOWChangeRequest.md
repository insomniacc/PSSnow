---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/New-SNOWChangeRequest.md
schema: 2.0.0
---

# New-SNOWChangeRequest

## SYNOPSIS
Creates a change_request record in SNOW

## SYNTAX

```
New-SNOWChangeRequest [[-backout_plan] <String>] [[-cab_date_time] <String>] [[-cab_delegate] <String>]
 [[-cab_recommendation] <String>] [[-cab_required] <Boolean>] [[-category] <String>] [[-change_plan] <String>]
 [[-chg_model] <String>] [[-close_code] <String>] [[-end_date] <String>] [[-implementation_plan] <String>]
 [[-justification] <String>] [[-on_hold] <Boolean>] [[-on_hold_reason] <String>] [[-on_hold_task] <String>]
 [[-outside_maintenance_schedule] <Boolean>] [[-phase] <String>] [[-phase_state] <String>]
 [[-production_system] <Boolean>] [[-reason] <String>] [[-requested_by] <String>]
 [[-requested_by_date] <String>] [[-review_comments] <String>] [[-review_date] <String>]
 [[-review_status] <String>] [[-risk] <String>] [[-risk_impact_analysis] <String>] [[-scope] <String>]
 [[-start_date] <String>] [[-test_plan] <String>] [[-type] <String>] [[-unauthorized] <Boolean>]
 [[-active] <Boolean>] [[-activity_due] <String>] [[-additional_assignee_list] <String>] [[-approval] <String>]
 [[-approval_history] <String>] [[-approval_set] <String>] [[-assigned_to] <String>]
 [[-assignment_group] <String>] [[-business_service] <String>] [[-closed_at] <String>] [[-closed_by] <String>]
 [[-close_notes] <String>] [[-cmdb_ci] <String>] [[-comments] <String>] [[-comments_and_work_notes] <String>]
 [[-company] <String>] [[-contact_type] <String>] [[-contract] <String>] [[-correlation_display] <String>]
 [[-correlation_id] <String>] [[-delivery_plan] <String>] [[-delivery_task] <String>] [[-description] <String>]
 [[-due_date] <String>] [[-expected_start] <String>] [[-follow_up] <String>] [[-group_list] <String>]
 [[-impact] <String>] [[-knowledge] <Boolean>] [[-location] <String>] [[-made_sla] <Boolean>]
 [[-opened_at] <String>] [[-opened_by] <String>] [[-order] <String>] [[-parent] <String>]
 [[-priority] <String>] [[-reassignment_count] <String>] [[-service_offering] <String>]
 [[-short_description] <String>] [[-sla_due] <String>] [[-state] <String>] [[-time_worked] <String>]
 [[-universal_request] <String>] [[-upon_approval] <String>] [[-upon_reject] <String>] [[-urgency] <String>]
 [[-user_input] <String>] [[-watch_list] <String>] [[-work_end] <String>] [[-work_notes] <String>]
 [[-work_notes_list] <String>] [[-work_start] <String>] [-ProgressAction <ActionPreference>] [-WhatIf]
 [-Confirm] [-Properties <Hashtable>] [-InputDisplayValue] [-PassThru] [-AsBatchRequest] [<CommonParameters>]
```

## DESCRIPTION
Creates a record in the change_request table

## EXAMPLES

### EXAMPLE 1
```powershell
"="<value>"} -PassThru
Creates a single record in change_request and returns the new record with SysID
```

## PARAMETERS

### -backout_plan
{{ Fill backout_plan Description }}

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

### -cab_date_time
{{ Fill cab_date_time Description }}

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

### -cab_delegate
{{ Fill cab_delegate Description }}

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

### -cab_recommendation
{{ Fill cab_recommendation Description }}

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

### -cab_required
{{ Fill cab_required Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -change_plan
{{ Fill change_plan Description }}

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

### -chg_model
{{ Fill chg_model Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: model

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -close_code
{{ Fill close_code Description }}

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

### -end_date
{{ Fill end_date Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: planned_end_date

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -implementation_plan
{{ Fill implementation_plan Description }}

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

### -justification
{{ Fill justification Description }}

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

### -on_hold
{{ Fill on_hold Description }}

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

### -on_hold_reason
{{ Fill on_hold_reason Description }}

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

### -on_hold_task
{{ Fill on_hold_task Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: on_hold_change_tasks

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -outside_maintenance_schedule
{{ Fill outside_maintenance_schedule Description }}

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

### -phase
{{ Fill phase Description }}

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

### -phase_state
{{ Fill phase_state Description }}

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

### -production_system
{{ Fill production_system Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -reason
{{ Fill reason Description }}

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

### -requested_by
{{ Fill requested_by Description }}

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

### -requested_by_date
{{ Fill requested_by_date Description }}

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

### -review_comments
{{ Fill review_comments Description }}

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

### -review_date
{{ Fill review_date Description }}

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

### -review_status
{{ Fill review_status Description }}

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

### -risk
{{ Fill risk Description }}

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

### -risk_impact_analysis
{{ Fill risk_impact_analysis Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: risk_and_impact_analysis

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scope
{{ Fill scope Description }}

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

### -start_date
{{ Fill start_date Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: planned_start_date

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -test_plan
{{ Fill test_plan Description }}

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

### -type
{{ Fill type Description }}

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

### -unauthorized
{{ Fill unauthorized Description }}

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

### -active
{{ Fill active Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -activity_due
{{ Fill activity_due Description }}

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

### -additional_assignee_list
{{ Fill additional_assignee_list Description }}

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

### -approval
{{ Fill approval Description }}

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

### -approval_history
{{ Fill approval_history Description }}

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

### -approval_set
{{ Fill approval_set Description }}

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

### -assigned_to
{{ Fill assigned_to Description }}

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

### -assignment_group
{{ Fill assignment_group Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -business_service
{{ Fill business_service Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: service

Required: False
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closed_at
{{ Fill closed_at Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: closed

Required: False
Position: 42
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closed_by
{{ Fill closed_by Description }}

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

### -close_notes
{{ Fill close_notes Description }}

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

### -cmdb_ci
{{ Fill cmdb_ci Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: configuration_item

Required: False
Position: 45
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -comments
{{ Fill comments Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: additional_comments

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -comments_and_work_notes
{{ Fill comments_and_work_notes Description }}

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

### -company
{{ Fill company Description }}

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

### -contact_type
{{ Fill contact_type Description }}

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

### -contract
{{ Fill contract Description }}

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

### -correlation_display
{{ Fill correlation_display Description }}

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

### -correlation_id
{{ Fill correlation_id Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -delivery_plan
{{ Fill delivery_plan Description }}

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

### -delivery_task
{{ Fill delivery_task Description }}

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

### -description
{{ Fill description Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -due_date
{{ Fill due_date Description }}

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

### -expected_start
{{ Fill expected_start Description }}

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

### -follow_up
{{ Fill follow_up Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -group_list
{{ Fill group_list Description }}

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

### -impact
{{ Fill impact Description }}

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

### -knowledge
{{ Fill knowledge Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 61
Default value: False
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
Position: 62
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -made_sla
{{ Fill made_sla Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 63
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -opened_at
{{ Fill opened_at Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: opened

Required: False
Position: 64
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -opened_by
{{ Fill opened_by Description }}

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

### -order
{{ Fill order Description }}

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

### -parent
{{ Fill parent Description }}

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

### -priority
{{ Fill priority Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 68
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reassignment_count
{{ Fill reassignment_count Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 69
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -service_offering
{{ Fill service_offering Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 70
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -short_description
{{ Fill short_description Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 71
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sla_due
{{ Fill sla_due Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 72
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -state
{{ Fill state Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 73
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -time_worked
{{ Fill time_worked Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 74
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -universal_request
{{ Fill universal_request Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 75
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -upon_approval
{{ Fill upon_approval Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 76
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -upon_reject
{{ Fill upon_reject Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 77
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -urgency
{{ Fill urgency Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 78
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -user_input
{{ Fill user_input Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 79
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -watch_list
{{ Fill watch_list Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 80
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -work_end
{{ Fill work_end Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: actual_end

Required: False
Position: 81
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -work_notes
{{ Fill work_notes Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 82
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -work_notes_list
{{ Fill work_notes_list Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 83
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -work_start
{{ Fill work_start Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: actual_start

Required: False
Position: 84
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

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: System.Management.Automation.ActionPreference
Parameter Sets: (All)
Aliases: proga

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

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWChangeRequest.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWChangeRequest.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


