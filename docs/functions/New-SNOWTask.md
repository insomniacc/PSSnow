---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/New-SNOWTask.md
schema: 2.0.0
---

# New-SNOWTask

## SYNOPSIS
Creates a task record in SNOW

## SYNTAX

```
New-SNOWTask [[-active] <Boolean>] [[-activity_due] <String>] [[-additional_assignee_list] <String>]
 [[-approval] <String>] [[-approval_history] <String>] [[-approval_set] <String>] [[-assigned_to] <String>]
 [[-assignment_group] <String>] [[-business_service] <String>] [[-cmdb_ci] <String>] [[-comments] <String>]
 [[-comments_and_work_notes] <String>] [[-delivery_plan] <String>] [[-delivery_task] <String>]
 [[-description] <String>] [[-due_date] <String>] [[-expected_start] <String>] [[-follow_up] <String>]
 [[-group_list] <String>] [[-impact] <String>] [[-made_sla] <Boolean>] [[-opened_at] <String>]
 [[-opened_by] <String>] [[-order] <String>] [[-parent] <String>] [[-priority] <String>]
 [[-service_offering] <String>] [[-short_description] <String>] [[-sla_due] <String>] [[-state] <String>]
 [[-urgency] <String>] [[-watch_list] <String>] [[-work_end] <String>] [[-work_notes] <String>]
 [[-work_notes_list] <String>] [[-work_start] <String>] [-WhatIf] [-Confirm] [-Properties <Hashtable>]
 [-InputDisplayValue] [-PassThru] [-AsBatchRequest] [<CommonParameters>]
```

## DESCRIPTION
Creates a record in the task table

## EXAMPLES

### EXAMPLE 1
```powershell
"="<value>"} -PassThru
Creates a single record in task and returns the new record with SysID
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

### -activity_due
{{ Fill activity_due Description }}

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

### -additional_assignee_list
{{ Fill additional_assignee_list Description }}

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

### -approval
{{ Fill approval Description }}

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

### -approval_history
{{ Fill approval_history Description }}

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

### -approval_set
{{ Fill approval_set Description }}

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

### -assigned_to
{{ Fill assigned_to Description }}

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

### -assignment_group
{{ Fill assignment_group Description }}

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

### -business_service
{{ Fill business_service Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: service

Required: False
Position: 9
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
Position: 10
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
Position: 11
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
Position: 12
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
Position: 13
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
Position: 14
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
Position: 15
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
Position: 16
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
Position: 17
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
Position: 18
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
Position: 19
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
Position: 20
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
Position: 21
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
Position: 22
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
Position: 23
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
Position: 24
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
Position: 25
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
Position: 26
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
Position: 27
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
Position: 28
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
Position: 29
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
Position: 30
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
Position: 31
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
Position: 32
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
Position: 33
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
Position: 34
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
Position: 35
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
Position: 36
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

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWTask.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWTask.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


