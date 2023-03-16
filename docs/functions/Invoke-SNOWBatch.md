---
external help file: PSServiceNow-help.xml
Module Name: PSServiceNow
online version: docs/functions/Invoke-SNOWBatch.md
schema: 2.0.0
---

# Invoke-SNOWBatch

## SYNOPSIS
Allows for multiple requests to be made via the ServiceNow Batch API

## SYNTAX

### Requests
```
Invoke-SNOWBatch -Requests <Object> [-BatchSize <Int32>] [-Parallel] [-Threads <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ScriptBlock
```
Invoke-SNOWBatch -ScriptBlock <ScriptBlock> [-BatchSize <Int32>] [-Parallel] [-Threads <Int32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Supported table operations can be wrapped with this command, instead of calls being made, all the requests will be grouped and sent to the batch api to be processed in parallel.
This lightens API usage but also speeds up much lager calls against lots of records.

## EXAMPLES

### EXAMPLE 1
```powershell
$Response = Invoke-SNOWBatch -scriptblock {
1..500 | ForEach-Object {
        $num = $_
        $Properties = @{
            user_name = "bruce.wayne$num"
            title = "Director"
            first_name = "Bruce"
            last_name = "Wayne"
            Department = "Finance"
            active = $false
            email = "Bruce$num@WayneIndustries.com"
            employee_number = "0000$num"
        }
        New-SNOWUser @Properties -Verbose
    }
}
$Response.serviced_requests | Group-Object -Property status_text
Creates 500 users in the sys_user table called bruce.wayne, instead of making 500 calls, the requests are split into batches of 150 (default) at a time.
```

### EXAMPLE 2
```powershell
$Response = Invoke-SNOWBatch -scriptblock {
1..100 | ForEach-Object {
        $num = $_
        $Properties = @{
            user_name = "bruce.wayne$num"
            title = "Director"
            first_name = "Bruce"
            last_name = "Wayne"
            Department = "Finance"
            active = $false
            email = "Bruce$num@WayneIndustries.com"
            employee_number = "0000$num"
        }
        New-SNOWUser @Properties -Verbose
    }
} -BatchSize 50  -Parallel
$Response.serviced_requests | Group-Object -Property status_text
Creates 100 users in the sys_user table called bruce.wayne, only 2 API calls (batches) are made to do this, both in parallel.
```

### EXAMPLE 3
```powershell
$UsersToDisable = Get-SNOWUser -active $true -department "Product Management"
$SNOWRequests = $UsersToDisable | Set-SNOWUser -active $false -AsBatchRequest
Invoke-SNOWBatch -Requests $SNOWRequests
Gets all the active users from a specific department, creates requests (as an array) to disable them all, passes that array into the Invoke-SNOWBatch to make the calls via the Batch API.
```

## PARAMETERS

### -Requests
Requests can be gathered from supporting commands with -AsBatchRequest

```yaml
Type: System.Object
Parameter Sets: Requests
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScriptBlock
This can be used to wrap supported commands in a scriptblock.
Instead of making individual calls they will be automatically grouped and sent to the batch API.

```yaml
Type: System.Management.Automation.ScriptBlock
Parameter Sets: ScriptBlock
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BatchSize
How many requests should go into each batch.
Too high and the calls could timeout.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 150
Accept pipeline input: False
Accept wildcard characters: False
```

### -Parallel
Batch calls will be made in parallel

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Threads
How many parallel calls to make against the Batch API

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 3
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

An array of 'requests'. These can be collected from supported commands by either issuing the -AsBatchRequest parameter or simply wrapping those commands with Invoke-SNOWBatch -scriptblock { <supported commands go here> }
## OUTPUTS

## NOTES

## RELATED LINKS

[https://docs.servicenow.com/bundle/tokyo-application-development/page/integrate/inbound-rest/concept/batch-api.html](https://docs.servicenow.com/bundle/tokyo-application-development/page/integrate/inbound-rest/concept/batch-api.html)


