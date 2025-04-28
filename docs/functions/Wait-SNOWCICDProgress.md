---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Wait-SNOWCICDProgress.md
schema: 2.0.0
---

# Wait-SNOWCICDProgress

## SYNOPSIS
Waits for a ServiceNow CICD operation to complete.

## SYNTAX

### ByProgressID (Default)
```
Wait-SNOWCICDProgress -ProgressID <String> [-TimeoutSec <Int32>] [-PollingIntervalSec <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### ByInputObject
```
Wait-SNOWCICDProgress -InputObject <PSObject> [-TimeoutSec <Int32>] [-PollingIntervalSec <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function polls the CICD progress API to check the status of a CICD operation
until it completes or times out.

This function calls the ServiceNow API endpoint: api/sn_cicd/progress/{progress_id}

## EXAMPLES

### EXAMPLE 1
```powershell
Wait-SNOWCICDProgress -ProgressID "1234567890abcdef" -TimeoutSec 300
```

Waits for the CICD operation with the specified progress ID to complete,
with a timeout of 5 minutes.

### EXAMPLE 2
```powershell
Wait-SNOWCICDProgress -ProgressID "1234567890abcdef" -PollingIntervalSec 5
```

Waits for the CICD operation to complete, checking the progress every 5 seconds.

### EXAMPLE 3
```powershell
Start-SNOWUpdateSetPreview -sys_id "1234567890abcdef" | Wait-SNOWCICDProgress
```

Starts a preview operation and waits for it to complete by piping the result to Wait-SNOWCICDProgress.

### EXAMPLE 4
```powershell
Start-SNOWUpdateSetCommit -sys_id "1234567890abcdef" | Wait-SNOWCICDProgress
```

Starts a commit operation and waits for it to complete by piping the result to Wait-SNOWCICDProgress.

## PARAMETERS

### -ProgressID
The progress_id returned from a CICD operation.

```yaml
Type: System.String
Parameter Sets: ByProgressID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
The result object returned from functions like Start-SNOWUpdateSetCommit or 
Start-SNOWUpdateSetPreview.
The function will extract the progress ID from this object.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: ByInputObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -TimeoutSec
The maximum time in seconds to wait for the operation to complete.
Default is 600 seconds (10 minutes).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 600
Accept pipeline input: False
Accept wildcard characters: False
```

### -PollingIntervalSec
The interval in seconds between polling attempts.
Default is 1 second.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1
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

## RELATED LINKS

