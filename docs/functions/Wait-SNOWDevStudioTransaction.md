---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Wait-SNOWDevStudioTransaction.md
schema: 2.0.0
---

# Wait-SNOWDevStudioTransaction

## SYNOPSIS
Wait for a sn_devstudio transaction to complete - api/sn_devstudio/v1/vcs/transactions/{ProgressId}

## SYNTAX

```
Wait-SNOWDevStudioTransaction [-ProgressId] <String> [[-MaxWaitSeconds] <Int32>] [[-ProgressInterval] <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function polls a sn_devstudio transaction progress endpoint 
and reports on its completion status.

It calls the ServiceNow API endpoint: api/sn_devstudio/v1/vcs/transactions/{ProgressId}

## EXAMPLES

### EXAMPLE 1
```powershell
Wait-SNOWDevStudioTransaction -ProgressId "abc123"
Waits for the specified transaction to complete, showing progress updates.
```

### EXAMPLE 2
```powershell
Wait-SNOWDevStudioTransaction -ProgressId "abc123" -MaxWaitSeconds 600 -ProgressInterval 100
Waits for the transaction with custom timeout and polling interval parameters.
```

## PARAMETERS

### -ProgressId
The ID of the transaction to monitor.

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

### -MaxWaitSeconds
The maximum time to wait for the transaction to complete in seconds.
Default is 1800 seconds (30 minutes).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 1800
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressInterval
The interval in milliseconds between progress checks.
Default is 50 milliseconds.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
This function requires an authenticated session to ServiceNow.

## RELATED LINKS

