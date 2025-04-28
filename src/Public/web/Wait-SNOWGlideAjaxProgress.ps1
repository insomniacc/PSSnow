<#
.SYNOPSIS
    Waits for a ServiceNow background process to complete.

.DESCRIPTION
    This function continuously polls a ServiceNow instance to monitor the progress of a background task
    until it completes or times out. It shows progress information using Write-Progress cmdlet.
    It requires a valid WebSession, which can be established using the `Set-SNOWAuth` function with 
    the `-UseWebSession` switch.

.PARAMETER sysparm_execution_id
    The execution ID of the background process to monitor.

.PARAMETER x_referer
    The referer information for the request.

.PARAMETER MaxWaitSeconds
    Maximum time to wait in seconds before timing out. Default is 1800 seconds (30 minutes).

.PARAMETER ProgressInterval
    Interval in milliseconds between progress checks. Default is 50 milliseconds.

.PARAMETER Activity
    The activity description to display in the progress bar. Default is 'Waiting'.

.EXAMPLE
    Wait-SNOWGlideAjaxProgress -sysparm_execution_id 'abcd1234' -x_referer 'update_set.do'

.NOTES
    - Requires a valid WebSession.
    - Returns a PSCustomObject with the status of the completed proces
#>

function Wait-SNOWGlideAjaxProgress {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$sysparm_execution_id,
        
        [Parameter(Mandatory = $false)]
        [string]$x_referer,
        
        [Parameter(Mandatory = $false)]
        [int]$MaxWaitSeconds = 1800, # 30 minutes
        
        [Parameter(Mandatory = $false)]
        [int]$ProgressInterval = 50
    )

    # Ensure authentication is valid
    Assert-SNOWAuth
    if (-not $Script:SNOWAuth.session) {
        Write-Error 'GlideAjax requests require a valid WebSession. Use Set-SNOWAuth with the -UseWebSession switch.' -ErrorAction Stop
    }

    # Prepare progress check parameters
    $ProgressParams = @{
        sysparm_execution_id          = $sysparm_execution_id
        sysparm_name                  = 'getStatus'
        'ni.nolog.x_referer'          = 'ignore'
        x_referer                     = $x_referer
        sysparm_want_session_messages = 'true'
        sysparm_processor             = 'AJAXProgressStatusChecker'
    }

    $StartTime = Get-Date
    Write-Verbose "Starting progress monitoring at $(Get-Date)"
    While ((Get-Date) -lt $StartTime.AddSeconds($MaxWaitSeconds)) {
        
        Start-Sleep -Milliseconds $ProgressInterval
        
        # Call GlideAjax to check progress
        $ProgressResponse = Invoke-SNOWGlideAjax -Params $ProgressParams
        
        if ($ProgressResponse.Answer.answer) {
            $CurrentProgress = $ProgressResponse.Answer.answer | ConvertFrom-JSON

            $ProgressReport = @{
                Activity         = ('{0} - {1}' -f $CurrentProgress.state, $CurrentProgress.name)
                Status           = "Progress -> $($CurrentProgress.percent_complete)%"
                PercentComplete  = $CurrentProgress.percent_complete
                CurrentOperation = 'Waiting'
            }
            
            Write-Debug ($CurrentProgress | ConvertTo-Json -Depth 10)
            
            if ([int]$CurrentProgress.state -gt 1) {
                Write-Verbose "Process completed with state: $($CurrentProgress.state)"
                Write-Progress @ProgressReport -Completed
                return $CurrentProgress
            }
            
            Write-Progress @ProgressReport
        }
        else {
            Write-Error 'No response from progress check' -ErrorAction Continue
            Write-Verbose "Failed to get progress update at $(Get-Date)"
        }
    }
    
    Write-Error "Operation timed out after $MaxWaitSeconds seconds" -ErrorAction Stop
}