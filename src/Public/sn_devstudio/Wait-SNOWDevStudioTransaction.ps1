function Wait-SNOWDevStudioTransaction {
    <#
    .SYNOPSIS
        Wait for a sn_devstudio transaction to complete - api/sn_devstudio/v1/vcs/transactions/{ProgressId}

    .DESCRIPTION
        This function polls a sn_devstudio transaction progress endpoint 
        and reports on its completion status.
        
        It calls the ServiceNow API endpoint: api/sn_devstudio/v1/vcs/transactions/{ProgressId}

    .PARAMETER ProgressId
        The ID of the transaction to monitor.

    .PARAMETER MaxWaitSeconds
        The maximum time to wait for the transaction to complete in seconds.
        Default is 1800 seconds (30 minutes).

    .PARAMETER ProgressInterval
        The interval in milliseconds between progress checks.
        Default is 50 milliseconds.

    .PARAMETER Activity
        The activity description displayed in the progress bar.
        Default is 'Waiting'.

    .EXAMPLE
        Wait-SNOWDevStudioTransaction -ProgressId "abc123"
        Waits for the specified transaction to complete, showing progress updates.

    .EXAMPLE
        Wait-SNOWDevStudioTransaction -ProgressId "abc123" -MaxWaitSeconds 600 -ProgressInterval 100
        Waits for the transaction with custom timeout and polling interval parameters.

    .NOTES
        This function requires an authenticated session to ServiceNow.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ProgressId,
        
        [Parameter(Mandatory = $false)]
        [int]$MaxWaitSeconds = 1800,
        
        [Parameter(Mandatory = $false)]
        [int]$ProgressInterval = 50
    )

    process {
        $StartTime = Get-Date
        while ((Get-Date) -lt $StartTime.AddSeconds($MaxWaitSeconds)) {
            Start-Sleep -Milliseconds $ProgressInterval
            $ProgressResponse = Invoke-SNOWRestMethod -Uri "api/sn_devstudio/v1/vcs/transactions/$ProgressId"
            
            if ($ProgressResponse.result) {
                $CurrentProgress = $ProgressResponse.result
                
                $ProgressReport = @{
                    Activity         = ('{0} - {1}' -f $CurrentProgress.state, $CurrentProgress.detailMessage)
                    Status           = "Progress-> $($CurrentProgress.percent_complete)"
                    PercentComplete  = [int]$CurrentProgress.percent_complete
                    CurrentOperation = $CurrentProgress.message
                }
                
                if ([int]$CurrentProgress.state -gt 1) {
                    $ProgressReport.Completed = $true
                }
                
                Write-Progress @ProgressReport
                
                if ($ProgressReport.Completed) {
                    return $CurrentProgress
                }
            }
            else {
                Write-Error 'No response from progress check'
            }
        }
        
        Write-Warning "Transaction did not complete within $MaxWaitSeconds seconds"
        return $null
    }
}
