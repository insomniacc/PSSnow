<#
    .SYNOPSIS
        Starts applying changes from a remote source control to a specified local application or application-customization.

    .DESCRIPTION
        This function calls the ServiceNow CICD API to start applying changes from a remote source control
        repository to a specified local application or application-customization.
        
        This function calls the ServiceNow API endpoint: api/sn_cicd/sc/apply_changes

    .PARAMETER Scope
        The scope name of the application for which to apply the changes, such as x_aah_custom_app.
        Required if SysID is not specified.

    .PARAMETER SysID
        The sys_id of the application for which to apply the changes.
        Required if Scope is not specified.

    .PARAMETER BranchName
        Name of the branch in the source control system from which to acquire the application.
        Default is the default branch specified on the source control system.

    .PARAMETER AutoUpgradeBaseApp
        Flag that indicates whether the system should auto upgrade the base application to a later version.
        Only applicable when changes are applied for app-customization and the latest commit on the Git repository
        is built on a version that is later than that of the base application that is currently installed on the local instance.
        Default is true.

    .EXAMPLE
        Start-SNOWVCSApplyChanges -Scope "x_aah_custom_app"
        
        Starts applying changes from the default branch to the application with the specified scope.

    .EXAMPLE
        Start-SNOWVCSApplyChanges -SysID "043db024db737300a9a754e4dc961915" -BranchName "develop" | Wait-SNOWCICDProgress
        
        Starts applying changes from the "develop" branch to the application with the specified sys_id and waits for completion.
    #>
function Start-SNOWVCSApplyChanges {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding(DefaultParameterSetName = 'BySysID', SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'ByScope')]
        [string]$Scope,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'BySysID')]
        [string]$SysID,
        
        [Parameter()]
        [string]$BranchName,
        
        [Parameter()]
        [bool]$AutoUpgradeBaseApp = $true
    )
    
    begin {
        $endpoint = "api/sn_cicd/sc/apply_changes"
        $queryParams = [System.Web.HttpUtility]::ParseQueryString([string]::Empty)
        
        # Add parameters based on which parameter set is used
        if ($PSCmdlet.ParameterSetName -eq 'ByScope') {
            $queryParams.Add("app_scope", $Scope)
            $targetDescription = "application scope '${Scope}'"
        }
        else {
            $queryParams.Add("app_sys_id", $SysID)
            $targetDescription = "application with sys_id '${SysID}'"
        }
        
        # Add optional parameters if specified
        if ($BranchName) {
            $queryParams.Add("branch_name", $BranchName)
            $branchInfo = " from branch '${BranchName}'"
        }
        else {
            $branchInfo = " from default branch"
        }
        
        $queryParams.Add("auto_upgrade_base_app", $AutoUpgradeBaseApp.ToString().ToLower())
        
        # Construct the query string
        $uriBuilder = New-Object System.UriBuilder
        $uriBuilder.Query = $queryParams.ToString()
        $queryString = $uriBuilder.Query
        
        # Construct the final endpoint URL
        $uri = "${endpoint}${queryString}"
    }
    
    process {
        try {
            $operationDescription = "Apply source control changes ${branchInfo} to ${targetDescription}"
            
            if ($PSCmdlet.ShouldProcess($targetDescription, $operationDescription)) {
                Write-Verbose "Starting to apply changes with endpoint: $uri"
                $result = Invoke-SNOWWebRequest -URI $uri -Method POST -ContentType "application/json" -UseRestMethod
                
                if ($result.result) {
                    Write-Verbose "Apply changes initiated with progress ID: $($result.result.links.progress.id)"
                    return $result
                }
                else {
                    Write-Error "Failed to start applying changes: $($result.error)"
                    return $null
                }
            }
        }
        catch {
            Write-Error "Error starting apply changes: $_"
            return $null
        }
    }
}
