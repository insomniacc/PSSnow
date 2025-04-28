<#
    .SYNOPSIS
        Removes (backs out) an update set from ServiceNow.

    .DESCRIPTION
        This function backs out an update set from ServiceNow using the CICD API.
        It returns the raw result object from the API which can be piped to Wait-SNOWCICDProgress
        to wait for the operation to complete.
        
        This function calls the ServiceNow API endpoint: api/sn_cicd/update_set/back_out

    .PARAMETER sys_id
        The sys_id of the update set to be backed out.

    .PARAMETER RollbackInstalls
        If specified, any batch installations performed during the update set commit will be rolled back.
        Default is false.

    .EXAMPLE
        Start-SNOWUpdateSetBackOut -sys_id "1234567890abcdef"
        
        Backs out the specified update set and returns the result object.
        
    .EXAMPLE
        Start-SNOWUpdateSetBackOut -sys_id "1234567890abcdef" -RollbackInstalls $true
        
        Backs out the update set and rolls back any batch installations.
        
    .EXAMPLE
        Start-SNOWUpdateSetBackOut -sys_id "1234567890abcdef" | Wait-SNOWCICDProgress
        
        Backs out the update set and waits for the process to complete.
    #>
function Start-SNOWUpdateSetBackOut {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [string]
        $Sys_ID,
        
        [Parameter()]
        [bool]$RollbackInstalls = $false
    )
    
    begin {
        if ($UpdateSet = Get-SNOWUpdateSet -sys_id $sys_id) {
            Write-Information "Update set with sys_id '${sys_id}' Current state: $($UpdateSet.state)"
        }
        else {
            Write-Error "Update set with sys_id '${sys_id}' not found."
            return $null
        }
    }
    
    process {
        if ($UpdateSet.state -ne 'complete') {
            Write-Warning "Update set with sys_id '${sys_id}' is not in a state that can be backed out. Current state: $($UpdateSet.state)"
            $RollbackInstalls = $false
        }
        $endpoint = 'api/sn_cicd/update_set/back_out?update_set_id={0}&rollback_installs={1}' -f $sys_id, $RollbackInstalls.ToString().ToLower()
        if ($PSCmdlet.ShouldProcess($endpoint, 'POST')) {
            Write-Information "Backing out update set with sys_id '${sys_id}'."
            $result = Invoke-SNOWWebRequest -Method POST -URI $endpoint -UseRestMethod -ContentType 'application/json'
            return $result.result
        }
    }
}
