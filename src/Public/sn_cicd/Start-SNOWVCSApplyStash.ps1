function Start-SNOWVCSApplyStash {
    <#
    .SYNOPSIS
        Starts applying a previously generated "stash" of changes from a remote source control.

    .DESCRIPTION
        This function calls the ServiceNow CICD API to start applying a previously generated "stash" of changes
        from a remote source control to a specified local application or application-customization.
        
        This function calls the ServiceNow API endpoint: api/sn_cicd/sc/apply_stash/{stash_id}

    .PARAMETER StashID
        Unique identifier of the stash to apply. This value is returned in the links.stash.id parameter
        in the corresponding GET /sn_cicd/progress/{progress_id} endpoint call.

    .EXAMPLE
        Start-SNOWVCSApplyStash -StashID "fc2224e4e0429110f8771827f8fd3634"
        
        Starts applying the specified stash.

    .EXAMPLE
        Start-SNOWVCSApplyStash -StashID "fc2224e4e0429110f8771827f8fd3634" | Wait-SNOWCICDProgress
        
        Starts applying the specified stash and waits for completion.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [string]$StashID
    )
    
    begin {
        $endpoint = "api/sn_cicd/sc/apply_stash/$StashID"
    }
    
    process {
        try {
            $targetDescription = "stash with ID '${StashID}'"
            $operationDescription = "Apply source control stash"
            
            if ($PSCmdlet.ShouldProcess($targetDescription, $operationDescription)) {
                Write-Verbose "Starting to apply stash with ID: $StashID"
                $result = Invoke-SNOWWebRequest -URI $endpoint -Method POST -ContentType "application/json" -UseRestMethod
                
                if ($result.result) {
                    Write-Verbose "Apply stash initiated with progress ID: $($result.result.links.progress.id)"
                    return $result
                }
                else {
                    Write-Error "Failed to start applying stash: $($result.error)"
                    return $null
                }
            }
        }
        catch {
            Write-Error "Error starting apply stash: $_"
            return $null
        }
    }
}
