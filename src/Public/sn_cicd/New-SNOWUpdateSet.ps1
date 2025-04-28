<#
    .SYNOPSIS
        Creates a new update set in ServiceNow using the CICD API.
    
    .DESCRIPTION
        Creates a new update set in ServiceNow using the CICD API.
        Requires either the sys_id or scope to identify the application.
        
        This function calls the ServiceNow API endpoint: api/sn_cicd/update_set/create

    .PARAMETER Name
        The name of the update set to create.
    
    .PARAMETER Description
        Optional description for the update set.
    
    .PARAMETER ApplicationSysId
        The sys_id of the application to associate the update set with.
    
    .PARAMETER Scope 
        The scope name of the application to associate the update set with.
    
    .EXAMPLE
        New-SNOWUpdateSet -Name "My Update Set" -Description "Contains my changes" -ApplicationSysId "123456789"
        
        Creates a new update set associated with the specified application sys_id.
    
    .EXAMPLE
        New-SNOWUpdateSet -Name "Scoped Update Set" -Scope "x_myapp_scope"
        
        Creates a new update set associated with the application having the specified scope.
        
    .EXAMPLE
        New-SNOWUpdateSet -Name "Dev Changes" -Description "Bug fix for issue #123" -ApplicationSysId "123456789" -WhatIf
        
        Shows what would happen if you created the update set, but doesn't actually create it.
    #>
function New-SNOWUpdateSet {
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'BySysId')]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $false)]
        [string]$Description,

        [Parameter(Mandatory = $true, ParameterSetName = 'BySysId')]
        [Alias('SysId')]
        [string]$ApplicationSysId,

        [Parameter(Mandatory = $true, ParameterSetName = 'ByScope')]
        [string]$Scope
    )
    begin {
        $ExistingUpdateSet = Get-SNOWObject -Table 'sys_update_set' -Query "name=$($Name)"
        if ($ExistingUpdateSet) {
            Write-Error "An update set with the name '$Name' already exists. Please choose a different name."
            return $null
        }
        $SysAppQuery = switch ($PSCmdlet.ParameterSetName) {
            'BySysId' { "sys_id=$($ApplicationSysId)" }
            'ByScope' { "scope=$($Scope)" }
        }
        $AppRecord = Get-SNOWObject -Table 'sys_app' -Query $SysAppQuery
        if (-not $AppRecord) {
            Write-Error "No application found with the specified sys_id or scope. Query: $SysAppQuery"
            return $null
        }
    }

    process {
        $baseUri = "api/sn_cicd/update_set/create?update_set_name=$Name&sys_id=$($AppRecord.sys_id)&sysparm_transaction_scope=$($AppRecord.sys_id)"

        # Add optional parameters
        if ($Description) {
            $baseUri += "&description=$Description"
        }
        if ($PSCmdlet.ShouldProcess($baseUri, 'POST')) {
            $response = Invoke-SNOWWebRequest -Uri $baseUri -Method POST -UseRestMethod -ContentType 'application/json'
            if ($response.result -and $response.result.update_set_id) {
                Write-Information "Successfully created update set with ID: $($response.result.update_set_id)"
                return Get-SNOWObject -Table 'sys_update_set' -Sys_ID $response.result.update_set_id
            }
            else {
                Write-Error "Failed to create update set. Response: $($response.error.message)"
                return $null
            }
        }
    }
}