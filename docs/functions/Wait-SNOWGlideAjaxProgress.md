---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Wait-SNOWGlideAjaxProgress.md
schema: 2.0.0
---

# Wait-SNOWGlideAjaxProgress

## SYNOPSIS
Waits for a ServiceNow background process to complete.

## SYNTAX

```
Wait-SNOWGlideAjaxProgress [-sysparm_execution_id] <String> [[-x_referer] <String>] [[-MaxWaitSeconds] <Int32>]
 [[-ProgressInterval] <Int32>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function continuously polls a ServiceNow instance to monitor the progress of a background task
until it completes or times out.
It shows progress information using Write-Progress cmdlet.
It requires a valid WebSession, which can be established using the \`Set-SNOWAuth\` function with 
the \`-UseWebSession\` switch.

## EXAMPLES

### EXAMPLE 1
```powershell
Wait-SNOWGlideAjaxProgress -sysparm_execution_id 'abcd1234' -x_referer 'update_set.do'
```

## PARAMETERS

### -sysparm_execution_id
The execution ID of the background process to monitor.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -x_referer
The referer information for the request.

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

### -MaxWaitSeconds
Maximum time to wait in seconds before timing out.
Default is 1800 seconds (30 minutes).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 1800
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressInterval
Interval in milliseconds between progress checks.
Default is 50 milliseconds.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 50
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
- Requires a valid WebSession.
- Returns a PSCustomObject with the status of the completed proces

## RELATED LINKS

