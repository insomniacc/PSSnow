function Start-SNOWVCSImport {
    <#
    .SYNOPSIS
        Imports an application using the specified repository URL and branch name.

    .DESCRIPTION
        This function calls the ServiceNow CICD API to import an application from source control in the calling instance.
        This allows you to use Continuous Integration and Continuous Delivery (CICD) endpoints to deploy the
        application to upper environments.
        
        This function calls the ServiceNow API endpoint: api/sn_cicd/sc/import

    .PARAMETER RepoURL
        Required. URL of the Git repository to import the application from.

    .PARAMETER BranchName
        Required. Name of the branch in the source control system to import the application from.

    .PARAMETER CredentialSysID
        Sys_id of the credentials that have access to the Git repository.
        Default is the sys_id set in the system properties.

    .PARAMETER MIDServerSysID
        Sys_id of the MID server to use for source control operations for this application.

    .PARAMETER AutoUpgradeBaseApp
        Flag that indicates whether the system should auto-upgrade the base application to a later version.
        Only applicable when the application being imported is an app-customization and the latest commit on
        the Git repository is built on a version that is later than that of the base application.
        Default is true.
    
    .PARAMETER TransactionScope
        The scope of the transaction to be used for the import. This is optional and can be set to a specific scope.
        Default is the current scope of the calling instance.

    .EXAMPLE
        Start-SNOWVCSImport -RepoURL "https://github.com/user/repo.git" -BranchName "main"
        
        Imports an application from the specified repository and branch.

    .EXAMPLE
        Start-SNOWVCSImport -RepoURL "https://github.com/user/repo.git" -BranchName "develop" -CredentialSysID "af9b6d6180feb010f8779c30d4dd6b6b" | Wait-SNOWCICDProgress
        
        Imports an application from the specified repository and branch using specific credentials and waits for completion.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "")]
    param (
        [Parameter(Mandatory = $true)]
        [string]$RepoURL,
        
        [Parameter(Mandatory = $true)]
        [string]$BranchName,
        
        [Parameter()]
        [string]$CredentialSysID,
        
        [Parameter()]
        [string]$MIDServerSysID,
        
        [Parameter()]
        [bool]$AutoUpgradeBaseApp = $true,

        [Parameter()]
        [string]$TransactionScope = 'global' # Default to global scope
    )
    
    begin {
        $endpoint = "api/sn_cicd/sc/import"
        $queryParams = [System.Web.HttpUtility]::ParseQueryString([string]::Empty)
        
        # Add required parameters
        $queryParams.Add("repo_url", $RepoURL)
        $queryParams.Add("branch_name", $BranchName)
        
        # Add optional parameters
        if ($CredentialSysID) {
            $queryParams.Add("credential_sys_id", $CredentialSysID)
        }
        
        if ($MIDServerSysID) {
            $queryParams.Add("mid_server_sys_id", $MIDServerSysID)
        }

        if ($TransactionScope) {
            $queryParams.Add("sysparm_transaction_scope", $TransactionScope)
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
            $targetDescription = "repository '${RepoURL}', branch '${BranchName}'"
            $operationDescription = "Import application from source control"
            
            if ($PSCmdlet.ShouldProcess($targetDescription, $operationDescription)) {
                Write-Verbose "Starting import from $RepoURL branch $BranchName"
                $result = Invoke-SNOWWebRequest -URI $uri -ContentType "application/json" `
                    -Method POST -UseRestMethod
                
                if ($result.result) {
                    Write-Verbose "Import initiated with progress ID: $($result.result.links.progress.id)"
                    return $result
                }
                else {
                    Write-Error "Failed to start import: $($result.error)"
                    return $null
                }
            }
        }
        catch {
            Write-Error "Error starting import: $_"
            return $null
        }
    }
}
