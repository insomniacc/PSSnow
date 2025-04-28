function Remove-SNOWUpdateSet {
    <#
    .SYNOPSIS
        Removes a ServiceNow update set by directly deleting it.

    .DESCRIPTION
        This function permanently deletes a ServiceNow update set using the ServiceNow REST API.
        It calls the ServiceNow API endpoint: api/now/table/{table}/{sys_id}
        
        WARNING: This operation is permanent and cannot be undone.

    .PARAMETER sys_id
        The sys_id of the update set to remove.

    .PARAMETER sys_class_name
        The system class name of the update set. Defaults to 'sys_update_set'.

    .EXAMPLE
        Remove-SNOWUpdateSet -sys_id "1234567890abcdef"
        
        Removes the specified update set after confirmation.
        
    .EXAMPLE
        Get-SNOWUpdateSet -Name "MyUpdateSet" | Remove-SNOWUpdateSet -Confirm:$false
        
        Gets an update set by name and removes it without confirmation.
        
    .EXAMPLE
        Remove-SNOWUpdateSet -sys_id "1234567890abcdef" -sys_class_name "custom_update_set"
        
        Removes an update set with a custom class name.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [string]$sys_id,
        
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string]$sys_class_name = 'sys_update_set'
    )
    
    begin {
        # Get update set details to retrieve application scope
        try {
            Write-Verbose "Retrieving update set information for sys_id: ${sys_id}"
            $updateSet = Get-SNOWObject -Table $sys_class_name -Query "sys_id=$sys_id" -Fields 'application'
            $appScope = $updateSet.application.value
            Write-Verbose "Application scope for update set: ${appScope}"
        }
        catch {
            Write-Warning "Failed to retrieve update set information: $_"
            $appScope = 'global'
        }
    }
    
    process {
        $endpoint = "api/now/table/${sys_class_name}/${sys_id}"
        
        # Add application scope as transaction scope if available
        if ($appScope) {
            $endpoint = "${endpoint}?sysparm_transaction_scope=${appScope}"
        }
        
        if ($PSCmdlet.ShouldProcess("Update set with ID ${sys_id}", "Delete")) {
            try {
                Invoke-SNOWWebRequest -Method DELETE -URI $endpoint -UseRestMethod -ErrorAction 'Stop' | Out-Null
                
                # DELETE requests typically return 204 No Content if successful
                Write-Verbose "Successfully removed update set with ID ${sys_id}"
                return @{
                    Success = $true
                    sys_id = $sys_id
                    Message = "Update set with ID ${sys_id} has been removed"
                }
            }
            catch {
                Write-Error "Failed to remove update set with ID ${sys_id}: $_"
                return @{
                    Success = $false
                    sys_id = $sys_id
                    Message = "Failed to remove update set: $_"
                }
            }
        }
    }
}
