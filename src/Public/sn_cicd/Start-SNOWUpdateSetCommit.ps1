function Start-SNOWUpdateSetCommit {
    <#
    .SYNOPSIS
        Starts the commit process for a ServiceNow update set.

    .DESCRIPTION
        This function starts the commit process for a ServiceNow update set using the CICD API.
        It returns the raw result object from the API which can be piped to Wait-SNOWCICDProgress
        to wait for the operation to complete.
        
        This function calls the ServiceNow API endpoint: api/sn_cicd/update_set/commit/{sys_id}
        
        https://www.servicenow.com/docs/bundle/yokohama-api-reference/page/integrate/inbound-rest/concept/cicd-update-set-api.html

    .PARAMETER sys_id
        The sys_id of the remote update set to be committed.

    .PARAMETER ForceCommit
        Switch that indicates whether to force commit the update set.
        Force commits the update set even if you haven't yet previewed it to check for conflicts.
        
        Default: Doesn't force commit the update set. You must preview the update set before proceeding with the commit.

    .EXAMPLE
        Start-SNOWUpdateSetCommit -sys_id "1234567890abcdef"
        
        Starts the commit process for the specified update set and returns the result.
        
    .EXAMPLE
        Start-SNOWUpdateSetCommit -sys_id "1234567890abcdef" | Wait-SNOWCICDProgress
        
        Starts the commit process and waits for it to complete by piping the result to Wait-SNOWCICDProgress.
        
    .EXAMPLE
        Get-SNOWUpdateSet -sys_id "1234567890abcdef" | Start-SNOWUpdateSetCommit | Wait-SNOWCICDProgress
        
        Gets the update set, starts the commit process, and waits for it to complete.

    .EXAMPLE
        Start-SNOWUpdateSetCommit -sys_id "1234567890abcdef" -ForceCommit
        
        Forces the commit process for the specified update set, bypassing validation checks.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('remote_update_set_id')]
        [string]$sys_id,
        [switch]$ForceCommit
    )
    
    process {
        $endpoint = "api/sn_cicd/update_set/commit/$sys_id"
        if ($PSCmdlet.ShouldProcess($endpoint, 'POST')) {
            $Body = @{
                force_commit = $ForceCommit.IsPresent
            } | ConvertTo-Json -Depth 3
            $result = Invoke-SNOWWebRequest -Method POST -URI $endpoint -UseRestMethod -ContentType "application/json" -Body $Body
            return $result.result
        }
    }
}
