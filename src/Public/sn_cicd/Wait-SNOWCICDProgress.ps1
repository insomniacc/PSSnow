function Wait-SNOWCICDProgress {
    <#
    .SYNOPSIS
        Waits for a ServiceNow CICD operation to complete.

    .DESCRIPTION
        This function polls the CICD progress API to check the status of a CICD operation
        until it completes or times out.
        
        This function calls the ServiceNow API endpoint: api/sn_cicd/progress/{progress_id}

    .PARAMETER ProgressID
        The progress_id returned from a CICD operation.

    .PARAMETER InputObject
        The result object returned from functions like Start-SNOWUpdateSetCommit or 
        Start-SNOWUpdateSetPreview. The function will extract the progress ID from this object.

    .PARAMETER TimeoutSec
        The maximum time in seconds to wait for the operation to complete.
        Default is 600 seconds (10 minutes).

    .PARAMETER PollingIntervalSec
        The interval in seconds between polling attempts. Default is 1 second.

    .EXAMPLE
        Wait-SNOWCICDProgress -ProgressID "1234567890abcdef" -TimeoutSec 300
        
        Waits for the CICD operation with the specified progress ID to complete,
        with a timeout of 5 minutes.

    .EXAMPLE
        Wait-SNOWCICDProgress -ProgressID "1234567890abcdef" -PollingIntervalSec 5
        
        Waits for the CICD operation to complete, checking the progress every 5 seconds.

    .EXAMPLE
        Start-SNOWUpdateSetPreview -sys_id "1234567890abcdef" | Wait-SNOWCICDProgress
        
        Starts a preview operation and waits for it to complete by piping the result to Wait-SNOWCICDProgress.

    .EXAMPLE
        Start-SNOWUpdateSetCommit -sys_id "1234567890abcdef" | Wait-SNOWCICDProgress
        
        Starts a commit operation and waits for it to complete by piping the result to Wait-SNOWCICDProgress.
    #>
    [CmdletBinding(DefaultParameterSetName = 'ByProgressID')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'ByProgressID')]
        [string]$ProgressID,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'ByInputObject', ValueFromPipeline = $true)]
        [PSObject]$InputObject,
        
        [Parameter()]
        [int]$TimeoutSec = 600,
        
        [Parameter()]
        [int]$PollingIntervalSec = 1
    )
    
    process {
        # Determine the progress ID from either direct parameter or input object
        if ($PSCmdlet.ParameterSetName -eq 'ByInputObject') {
            # Handle different possible structures of the input object
            if ($InputObject.links.progress.id) {
                $ProgressID = $InputObject.links.progress.id
            }
            elseif ($InputObject.result.links.progress.id) {
                $ProgressID = $InputObject.result.links.progress.id
            }
            elseif ($InputObject.CommitStart.links.progress.id) {
                $ProgressID = $InputObject.CommitStart.links.progress.id
            }
            elseif ($InputObject.ProgressId) {
                $ProgressID = $InputObject.ProgressId
            }
            else {
                Write-Error "Could not find progress ID in the provided input object."
                return $null
            }
        }
        
        $endpoint = "api/sn_cicd/progress/$ProgressID"
        $startTime = Get-Date
        $completed = $false
        
        Write-Verbose "Starting to monitor progress ID $ProgressID"
        
        while (-not $completed) {
            $elapsedTime = (Get-Date) - $startTime
            if ($elapsedTime.TotalSeconds -gt $TimeoutSec) {
                Write-Error "Operation timed out after $TimeoutSec seconds."
                return $null
            }
            
            $result = Invoke-SNOWWebRequest -Method GET -URI $endpoint -UseRestMethod
            
            if (-not $result -or -not $result.result) {
                Start-Sleep -Seconds $PollingIntervalSec
                continue
            }
            
            $status = $result.result.status
            $Activity = if ($result.result.status_detail) {
                $result.result.status_detail
            }
            elseif ($result.result.status_message) {
                $result.result.status_message
            }
            else {
                $result.result.status_label
            }
            $Activity = "sn_cicd - $Activity"
            Write-Progress -Activity $Activity  -Status "$($result.result.status_label): $($result.result.status_message)" -PercentComplete $result.result.percent_complete
            
            if ($status -eq "2") {
                $completed = $true
                Write-Progress -Activity $Activity -Completed
                return $result.result
            }
            elseif ($status -eq "3") {
                Write-Error "CICD operation failed: $($result.result.status_message) ($($result.result.status_detail))"
                return $result.result
            }
            
            Start-Sleep -Seconds $PollingIntervalSec
        }
        
        return $null
    }
}
