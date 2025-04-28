function Start-SNOWUpdateSetPreview {
    <#
    .SYNOPSIS
        Starts the preview process for a ServiceNow update set.

    .DESCRIPTION
        This function starts the preview process for a ServiceNow update set using the CICD API.
        It returns the raw result object from the API which can be piped to Wait-SNOWCICDProgress
        to wait for the operation to complete.
        
        This function calls the ServiceNow API endpoint: api/sn_cicd/update_set/preview/{sys_id}

    .PARAMETER sys_id
        The sys_id of the remote update set to be previewed.

    .EXAMPLE
        Start-SNOWUpdateSetPreview -sys_id "1234567890abcdef"
        
        Starts the preview process for the specified update set and returns the result.
        
    .EXAMPLE
        Start-SNOWUpdateSetPreview -sys_id "1234567890abcdef" | Wait-SNOWCICDProgress
        
        Starts the preview process and waits for it to complete by piping the result to Wait-SNOWCICDProgress.

    .EXAMPLE
        Get-SNOWUpdateSet -sys_id "1234567890abcdef" | Start-SNOWUpdateSetPreview | Wait-SNOWCICDProgress
        
        Gets the update set, starts the preview process, and waits for it to complete.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('remote_update_set_id')]
        [string]$sys_id
    )
    
    process {
        $endpoint = "api/sn_cicd/update_set/preview/$sys_id"
        if ($PSCmdlet.ShouldProcess($endpoint, 'POST')) {
            $result = Invoke-SNOWWebRequest -Method POST -URI $endpoint -UseRestMethod -ContentType "application/json"
            return $result.result
        }
    }
}
