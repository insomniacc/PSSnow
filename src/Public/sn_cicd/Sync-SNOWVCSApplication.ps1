function Sync-SNOWVCSApplication {
    <#
    .SYNOPSIS
        Synchronizes a ServiceNow application with a Git repository using the CICD Source Control API.

    .DESCRIPTION
        This function synchronizes a ServiceNow application with a Git repository using the modern
        Source Control APIs available in the ServiceNow CICD module. It can import new applications
        or apply changes to existing ones from source control repositories.
        
        This function leverages the ServiceNow API endpoints under api/sn_cicd/sc/ paths.

    .PARAMETER Scope
        The scope name of the ServiceNow application, such as x_acme_app.
        Required if SysID is not specified.

    .PARAMETER SysID
        The sys_id of the ServiceNow application.
        Required if Scope is not specified.

    .PARAMETER RepoURL
        Required. The URL of the Git repository.

    .PARAMETER BranchName
        The Git branch to synchronize with. Default is the default branch specified in the source control system.

    .PARAMETER Credential
        The credentials used to access the Git repository. Will be stored in ServiceNow as a basic_auth_credential record.

    .PARAMETER DefaultUser
        The default user email to use for Git operations.

    .PARAMETER MIDServerSysID
        The sys_id of the MID server to use for source control operations.

    .PARAMETER AutoUpgradeBaseApp
        Flag that indicates whether the system should auto-upgrade the base application to a later version.
        Default is true.

    .PARAMETER ImportIfMissing
        If specified, imports the application if it doesn't exist in the instance.

    .PARAMETER ApplyChanges
        If specified, applies changes from the remote repository to the local instance.

    .PARAMETER Force
        If specified, forces operations even if conflicts might occur.

    .PARAMETER TimeoutSec
        The maximum time in seconds to wait for operations to complete. Default is 600 seconds (10 minutes).

    .EXAMPLE
        Sync-SNOWVCSApplication -Scope "x_acme_app" -RepoURL "https://github.com/org/repo.git" -BranchName "main" -Credential $cred -ApplyChanges
        
        Applies changes from the main branch of the specified repository to the application with scope x_acme_app.

    .EXAMPLE
        Sync-SNOWVCSApplication -SysID "043db024db737300a9a754e4dc961915" -RepoURL "https://github.com/org/repo.git" -BranchName "develop" -Credential $cred -DefaultUser "user@example.com" -ImportIfMissing
        
        Imports the application from the develop branch if it doesn't exist in the instance.

    .NOTES
        This function requires an authenticated session to ServiceNow with appropriate permissions for CICD operations.
    #>
    [CmdletBinding(DefaultParameterSetName = 'BySysID')]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'ByScope')]
        [string]$Scope,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'BySysID')]
        [string]$SysID,
        
        [Parameter(Mandatory = $true)]
        [string]$RepoURL,
        
        [Parameter()]
        [string]$BranchName,
        
        [Parameter(Mandatory = $true)]
        [pscredential]$Credential,
        
        [Parameter()]
        [string]$DefaultUser,
        
        [Parameter()]
        [string]$MIDServerSysID,
        
        [Parameter()]
        [bool]$AutoUpgradeBaseApp = $true,
        
        [Parameter()]
        [switch]$ImportIfMissing,
        
        [Parameter()]
        [switch]$ApplyChanges,
        
        [Parameter()]
        [switch]$Force,
        
        [Parameter()]
        [int]$TimeoutSec = 600
    )

    process {
        # First handle credential management
        Write-Verbose "Managing credentials for Git repository access"
        $RepoName = ($RepoURL -split '/')[-1] -replace '\.git$', '' -replace '[^a-zA-Z0-9]', '_'
        $credentialName = "VCS_$RepoName".SubString([System.Math]::Min(15, $String.Length))
        
        $credentialValues = @{
            name      = $credentialName
            type      = "basic_auth"
            user_name = $Credential.UserName
            password  = $Credential.GetNetworkCredential().Password
        }
        
        if ($DefaultUser) {
            $credentialValues["email"] = $DefaultUser
        }
        
        $credentialQuery = "nameSTARTSWITH${credentialName}^type=basic_auth"
        $existingCredential = Get-SNOWObject -Table 'basic_auth_credentials' -Query $credentialQuery
        
        if ($existingCredential) {
            Write-Verbose "Updating existing credential record: ${existingCredential.sys_id}"
            $credentialRecord = Set-SNOWObject -Table 'basic_auth_credentials' -Sys_Id $existingCredential.sys_id -Properties $credentialValues -PassThru
        }
        else {
            Write-Verbose "Creating new credential record"
            $credentialRecord = New-SNOWObject -Table 'basic_auth_credentials' -Properties $credentialValues -PassThru
        }
        
        if (-not $credentialRecord -or -not $credentialRecord.sys_id) {
            Write-Error "Failed to create or update credential record"
            return
        }
        
        $credentialSysID = $credentialRecord.sys_id
        Write-Verbose "Using credential sys_id: ${credentialSysID}"
        
        # Check if application exists
        $appExists = $false
        
        if ($PSCmdlet.ParameterSetName -eq 'ByScope') {
            $appQuery = "scope=${Scope}^"
            $appObj = Get-SNOWObject -Table 'sys_app' -Query $appQuery -ErrorAction SilentlyContinue
            if ($appObj) {
                $appExists = $true
                $SysID = $appObj.sys_id
                $Scope = $appObj.scope
                Write-Host "Found application with scope ${Scope} - sys_id: ${SysID}"
            }
        }
        else {
            $appObj = Get-SNOWObject -Table 'sys_app' -Sys_Id $SysID -ErrorAction SilentlyContinue
            if ($appObj) {
                $appExists = $true
                $Scope = $appObj.scope
                $SysID = $appObj.sys_id
                Write-Host "Found application with sys_id ${SysID} - scope: ${Scope}"
            }
        }
        $AppRepo = Get-SNOWObject -Table 'sys_repo_config' -Query "url=${RepoURL}^"
        # The sn_cicd/sc/import endpoint does
        if ($appObj.sys_id) {
            if (-not $AppRepo) {
                Write-Warning "Application $($appObj.sys_id) exists - but no sys_repo_config found. Creating sys_repo_config record for the application."
                $RepoProps = @{
                    short_description        = "Imported by PSSnow"
                    sys_app                  = $appObj.sys_id
                    current_branch           = $BranchName
                    default_commit_email     = ""
                    url                      = $RepoURL
                    credential               = $CredentialSysID
                    use_default_commit_email = "false"
                    authentication           = "basic_authentication"
                }
                $SysRepoConfig = New-SNOWObject -Table 'sys_repo_config' -Properties $RepoProps -PassThru
                if ($SysRepoConfig) {
                    Write-Verbose "Created sys_repo_config record with sys_id: $($SysRepoConfig.sys_id)"
                }
                else {
                    Write-Error "Failed to create sys_repo_config record for the application"
                    return
                }
            }
        }
        elseif ($AppRepo -and (-not $AppObj.sys_id)) {
            Write-Warning "Found sys_repo_config record for the URL ${RepoURL} with sys_id: $($AppRepo.sys_id) but no associated application."
            # If we have a sys_repo_config but no sys_app, we can still import
            Remove-SNOWObject -Table 'sys_repo_config' -Sys_Id $AppRepo.sys_id -Confirm:$false
        }
        
        if ($AppRepo -and $AppRepo.sys_app -eq '') {
            Write-Warning "Deleting existing repository configuration with URL ${RepoURL} and no associated application"
            Remove-SNOWObject -Table 'sys_repo_config' -Sys_Id $AppRepo.sys_id -Confirm:$false
        }
        
        # If app doesn't exist and ImportIfMissing is specified, import it
        if ((-not $appExists -and $ImportIfMissing)) {
            Write-Verbose "Application doesn't exist. Importing from repository."
            $importParams = @{
                RepoURL            = $RepoURL
                CredentialSysID    = $credentialSysID
                AutoUpgradeBaseApp = $AutoUpgradeBaseApp
            }
            
            if ($BranchName) {
                $importParams.BranchName = $BranchName
            }
            else {
                Write-Error "BranchName parameter is required when importing a new application"
                return
            }
            
            if ($MIDServerSysID) {
                $importParams.MIDServerSysID = $MIDServerSysID
            }

            Write-Verbose "Starting application import from ${RepoURL}"
            $importResult = Start-SNOWVCSImport @importParams
            
            if (-not $importResult -or -not $importResult.result) {
                Write-Error "Failed to import application from repository"
                return
            }
            
            # Wait for the import to complete
            Write-Verbose "Import initiated with progress ID: $($importResult.result.links.progress.id)"
            $progressResult = $importResult | Wait-SNOWCICDProgress -TimeoutSec $TimeoutSec
            
            if ($progressResult.status -ne "2") {
                Write-Error "Import failed: $($progressResult.status_message)"
                return $progressResult
            }
            
            Write-Output "Import completed successfully: $($progressResult.status_message)"
            
            # Re-fetch the app details to get the sys_id if we imported by scope
            if ($PSCmdlet.ParameterSetName -eq 'ByScope') {
                $appObj = Get-SNOWObject -Table 'sys_app' -Query $appQuery
                if ($appObj) {
                    $SysID = $appObj.sys_id
                    Write-Verbose "Imported application with scope ${Scope} - sys_id: ${SysID}"
                }
            }
            
            return $progressResult
        } 
        elseif (-not $appExists) {
            Write-Error "Application doesn't exist and ImportIfMissing parameter was not specified"
            return
        }
        
        # If app exists and ApplyChanges is specified, apply changes from repository
        if ($appExists -and $ApplyChanges) {
            Write-Verbose "Applying changes from repository to existing application"
            
            $applyParams = @{
                AutoUpgradeBaseApp = $AutoUpgradeBaseApp
            }
            
            $applyParams.SysId = $appObj.sys_id
            if ($BranchName) {
                $applyParams.BranchName = $BranchName
            }
            
            Write-Verbose "Starting to apply changes to application"
            $applyResult = Start-SNOWVCSApplyChanges @applyParams
            
            if (-not $applyResult -or -not $applyResult.result) {
                Write-Error "Failed to apply changes from repository"
                return
            }
            
            # Wait for the apply changes operation to complete
            Write-Verbose "Apply changes initiated with progress ID: $($applyResult.result.links.progress.id)"
            $progressResult = $applyResult | Wait-SNOWCICDProgress -TimeoutSec $TimeoutSec
            
            if ($progressResult.status -ne "2") {
                Write-Error "Apply changes failed: $($progressResult.status_message)"
                return $progressResult
            }
            
            Write-Output "Apply changes completed successfully: $($progressResult.status_message)"
            
            # Check if we have a stash to apply
            if ($progressResult.links.stash -and $progressResult.links.stash.id) {
                Write-Verbose "Detected stash to apply with ID: $($progressResult.links.stash.id)"
                
                if (-not $Force) {
                    Write-Warning "Stash detected but Force parameter not specified. Use -Force to apply stash."
                    return $progressResult
                }
                
                $stashResult = Start-SNOWVCSApplyStash -StashID $progressResult.links.stash.id
                
                if (-not $stashResult -or -not $stashResult.result) {
                    Write-Error "Failed to apply stash"
                    return $progressResult
                }
                
                # Wait for the stash application to complete
                Write-Verbose "Apply stash initiated with progress ID: $($stashResult.result.links.progress.id)"
                $stashProgressResult = $stashResult | Wait-SNOWCICDProgress -TimeoutSec $TimeoutSec
                
                if ($stashProgressResult.status -ne "2") {
                    Write-Error "Apply stash failed: $($stashProgressResult.status_message)"
                    return $stashProgressResult
                }
                
                Write-Output "Apply stash completed successfully: $($stashProgressResult.status_message)"
                return $stashProgressResult
            }
            
            return $progressResult
        }
        
        # If we reach here, either the app exists but no action was specified
        if ($appExists -and -not $ApplyChanges) {
            Write-Warning "Application exists but no action was specified. Use -ApplyChanges to update from repository."
            return $appObj
        }
    }
}
