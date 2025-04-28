function Sync-SNOWDevStudioApp {
    <#
    .SYNOPSIS
        Imports, syncs and updates a ServiceNow application with a Git repository. Use sn_devstudio API endpoints to manage the repository.

    .DESCRIPTION
        This function synchronizes a ServiceNow application with a Git repository
        by setting up the VCS integration and managing branch synchronization.
        This function uses the ServiceNow Dev Studio API - which is the same API that SN Studio uses when managing a repository.
        This function still works in some fringe cases where an application exists but the repo does not. 

    .PARAMETER ScopeName
        The scope name of the ServiceNow application.

    .PARAMETER AppName
        The name of the ServiceNow application.

    .PARAMETER RepoUri
        The URI of the Git repository.

    .PARAMETER Credential
        The credentials used to access the Git repository.

    .PARAMETER Branch
        The Git branch to synchronize with.

    .PARAMETER DefaultUser
        The default user email to use for Git operations.

    .PARAMETER ApplyRemoteChanges
        If specified, applies remote changes to the local instance.

    .PARAMETER Force
        If specified, forces operations even if local changes exist.

    .EXAMPLE
        Sync-SNOWDevStudioApp -ScopeName "x_acme_app" -AppName "ACME App" -RepoUri "https://github.com/org/repo.git" -Credential $cred -Branch "main" -DefaultUser "user@example.com"

    .NOTES
        This function requires an authenticated session to ServiceNow.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ScopeName,
        
        [Parameter(Mandatory = $true)]
        [string]$AppName,
        
        [Parameter(Mandatory = $true)]
        [string]$RepoUri,
        
        [Parameter(Mandatory = $true)]
        [pscredential]$Credential,
        
        [Parameter(Mandatory = $true)]
        [string]$Branch,
        
        [Parameter(Mandatory = $true)]
        [string]$DefaultUser,
        
        [Parameter(Mandatory = $false)]
        [switch]$ApplyRemoteChanges,
        
        [Parameter(Mandatory = $false)]
        [switch]$Force
    )

    process {
        # Create or update the credential record
        $CredentialValues = @{
            name      = ("vcs $ScopeName" -replace '^(.{0,32}).*', '$1')
            user_name = $Credential.UserName
            password  = $Credential.GetNetworkCredential().Password
        }
        
        $CredentialSyncRequest = @{
            Table                 = 'basic_auth_credentials'
            Query                 = "nameEQ$($CredentialValues.name)^"
            Body                  = $CredentialValues
            Recreate              = $false
            AdditionalQueryParams = @{
                'sysparm_input_display_value' = 'true'
                'sysparm_display_value'       = 'true'
            }
        }
        $VCSCredential = Get-SNOWObject -Table $CredentialSyncRequest.Table -Query $CredentialSyncRequest.Query
        if (!$VCSCredential) {
            $VCSCredential = New-SNOWObject -Table $CredentialSyncRequest.Table -Properties $CredentialSyncRequest.Body -InputDisplayValue -PassThru
        }
        else {
            $VCSCredential = Set-SNOWObject -Table $CredentialSyncRequest.Table -Sys_ID $VCSCredential.sys_id -Properties $CredentialSyncRequest.Body -InputDisplayValue -PassThru
        }
        
        if (-not $VCSCredential.sys_id) {
            Write-Error "Failed to sync credential for $ScopeName"
            return
        }
        
        # Define VCS app parameters
        $VCSAppParams = @{
            url                       = $RepoUri
            branch                    = $Branch
            defaultBranchName         = $Branch
            remoteDefaultBranchName   = $Branch
            credential                = $VCSCredential.sys_id
            email                     = $DefaultUser
            use_default_email_for_all = $true
            setTestConnection         = $true
            mid_server                = ''
        }
        
        # Get VCS apps and find the specific app
        $VCSApps = Get-SNOWDevStudioApp
        $ScopeApp = $VCSApps.apps | Where-Object { $_.scope -eq $ScopeName -and $_.name -eq $AppName }
        
        if (-not $ScopeApp) {
            # Create a new VCS app if it doesn't exist
            $CreateAppRequest = @{
                Uri         = 'api/sn_devstudio/v1/vcs/apps'
                Method      = 'POST'
                Body        = ($VCSAppParams | ConvertTo-Json -Depth 5)
                ContentType = 'application/json'
            }
            
            $CreateResponse = Invoke-SNOWWebRequest @CreateAppRequest
            
            if ($CreateResponse.StatusCode -ne 202) {
                Write-Error "Failed to create VCS app for $ScopeName - $($CreateResponse.Content)"
                return
            }
            
            $CreateResult = ($CreateResponse.Content | ConvertFrom-Json).result
            
            if ($CreateResult.progressId) {
                $CreateProgress = Wait-SNOWDevStudioTransaction -ProgressId $CreateResult.progressId
                
                if ($CreateProgress.state -eq 2) {
                    return Sync-SNOWDevStudioApp @PSBoundParameters
                }
                else {
                    Write-Error "Failed to create VCS app for $ScopeName - $($CreateProgress | ConvertTo-Json)"
                    return
                }
            }
            
            Write-Warning "No VCS app found for $ScopeName"
        }
        else {
            # Handle existing app
            $TransactionScope = $ScopeApp.sysId
            
            if ($ScopeName -eq 'global') {
                $TransactionScope = 'global'
            }
            
            if (-not $ScopeApp.vcs.repoId) {
                # Create temporary branch if repo doesn't exist
                $TemporaryBranchName = "sn_instances/$($Script:SNOWAuth.Instance)"
                Write-Warning "No VCS repo found for $ScopeName - Creating temporary branch: $TemporaryBranchName"
                
                $TempBranchParams = $VCSAppParams.Clone()
                $TempBranchParams['branch'] = $TemporaryBranchName
                $TempBranchParams['defaultBranchName'] = $TemporaryBranchName
                $TempBranchParams['remoteDefaultBranchName'] = $TemporaryBranchName
                
                $TempBranchRequest = @{
                    Uri           = "api/sn_devstudio/v1/vcs/apps/$($ScopeApp.sysId)/repos?sysparm_transaction_scope=$($TransactionScope)"
                    Method        = 'POST'
                    Body          = ($TempBranchParams | ConvertTo-Json -Depth 5)
                    ContentType   = 'application/json'
                    UseRestMethod = $true
                }
                
                $TempBranchResponse = Invoke-SNOWWebRequest @TempBranchRequest
                
                if ($TempBranchResponse.result.progressId) {
                    Write-Information "Temporary branch creation started. Progress ID: $($TempBranchResponse.result.progressId)"
                    $ProgressResult = Wait-SNOWDevStudioTransaction -ProgressId $TempBranchResponse.result.progressId 
                    
                    if ($ProgressResult.state -eq 2) {
                        return Sync-SNOWDevStudioApp @PSBoundParameters
                    }
                }
                else {
                    Write-Error "Failed to create temporary branch for $ScopeName - $($TempBranchResponse | ConvertTo-Json)"
                }
            }
            else {
                # Update existing repo configuration
                $VcsUri = "api/sn_devstudio/v1/vcs/apps/$($ScopeApp.sysId)"
                $RepoUri = "$VcsUri/repos/$($ScopeApp.vcs.repoId)"
                $ScopeVcs = Invoke-SNOWWebRequest -URI $VcsUri -Method GET -UseRestMethod
                $ScopeVcs = $ScopeVcs.result
                
                # Update credential if needed
                if (-not $ScopeVcs.credentialId -or ($ScopeVcs.credentialId -ne $VCSAppParams.credential) -or $Force) {
                    Write-Warning "Credential mismatch for $ScopeName - Updating credential"
                    
                    $UpdateCredentialRequest = @{
                        Uri           = "$($RepoUri)?sysparm_transaction_scope=$($TransactionScope)"
                        Method        = 'PUT'
                        Body          = $VCSAppParams
                        ContentType   = 'application/json'
                        UseRestMethod = $true
                    }
                    
                    $UpdateCredentialResponse = Invoke-SNOWWebRequest @UpdateCredentialRequest
                    
                    if ($UpdateCredentialResponse.result.progressId) {
                        Write-Information "Credential update started. Progress ID: $($UpdateCredentialResponse.result.progressId)"
                        $ProgressResult = Wait-SNOWDevStudioTransaction -ProgressId $UpdateCredentialResponse.result.progressId 
                        
                        if ($ProgressResult.state -eq 2) {
                            Write-Information "Credential updated successfully for $ScopeName"
                        }
                        else {
                            Write-Error "Failed to update credential for $ScopeName - $($ProgressResult | ConvertTo-Json)"
                            return
                        }
                    }
                    else {
                        Write-Error "Failed to update credential for $ScopeName - $($UpdateCredentialResponse.result)"
                    }
                }
                
                # Switch branch if needed
                if ($ScopeApp.vcs.currentBranch -ne $Branch) {
                    Write-Warning "Branch mismatch for $ScopeName - Switching to branch: $Branch"
                    
                    $UpdateBranchRequest = @{
                        Uri           = "api/sn_devstudio/v1/vcs/apps/$($ScopeApp.sysId)/repos/$($ScopeApp.vcs.repoId)/branches/switch?sysparm_transaction_scope=$($TransactionScope)"
                        Method        = 'PUT'
                        Body          = (@{
                                branchName           = $Branch
                                preserveLocalChanges = $false
                                stashMessage         = "Stashing local changes before switching to branch $Branch"
                                appId                = $ScopeApp.sysId
                            } | ConvertTo-Json -Depth 5)
                        ContentType   = 'application/json'
                        UseRestMethod = $true
                    }
                    
                    $UpdateBranchResponse = Invoke-SNOWWebRequest @UpdateBranchRequest
                    
                    if ($UpdateBranchResponse.result.progressId) {
                        Write-Information "Branch switch started. Progress ID: $($UpdateBranchResponse.result.progressId)"
                        $ProgressResult = Wait-SNOWDevStudioTransaction -ProgressId $UpdateBranchResponse.result.progressId 
                        
                        if ($ProgressResult.state -eq 2) {
                            return Sync-SNOWDevStudioApp @PSBoundParameters
                        }
                    }
                    else {
                        Write-Error "Failed to switch branch for $ScopeName - $($UpdateBranchResponse.result)"
                    }
                }
                else {
                    # Refresh branch
                    $RefreshBranchRequest = @{
                        Uri           = "api/sn_devstudio/v1/vcs/apps/$($ScopeApp.sysId)/repos/$($ScopeApp.vcs.repoId)/refresh?sysparm_transaction_scope=$($TransactionScope)"
                        Method        = 'POST'
                        ContentType   = 'application/json'
                        UseRestMethod = $true
                    }
                    
                    $RefreshBranchResponse = Invoke-SNOWWebRequest @RefreshBranchRequest
                    
                    if ($RefreshBranchResponse.result.progressId) {
                        $RefreshResult = Wait-SNOWDevStudioTransaction -ProgressId $RefreshBranchResponse.result.progressId
                        Write-Information "Branch refresh completed. Details: $($RefreshResult.detailMessage)"
                        if ($RefreshResult.state -ne '2') {
                            Write-Warning "Branch refresh failed for $ScopeName. Details: $($RefreshResult | ConvertTo-Json)"
                            return $RefreshResult
                        }
                        
                        # Apply remote changes if requested
                        if ($ApplyRemoteChanges) {
                            $ApplyUri = "api/sn_devstudio/v1/vcs/apps/$($ScopeApp.sysId)/repos/$($ScopeApp.vcs.repoId)/apply?sysparm_transaction_scope=$TransactionScope"
                            $RepoState = Invoke-SNOWWebRequest -URI "api/sn_devstudio/v1/vcs/apps/$($ScopeApp.sysId)" -Method GET
                            
                            if ($RepoState.result.hasRemoteChanges) {
                                $UserHost = (hostname -f)
                                $ApplyRequest = @{
                                    Uri           = $ApplyUri
                                    Method        = 'POST'
                                    Body          = @{
                                        executeEvenIfDirty   = $true
                                        preserveLocalChanges = $true
                                        stashMessage         = "Stashing from $UserHost"
                                    }
                                    ContentType   = 'application/json'
                                    UseRestMethod = $true
                                }
                                
                                if ($RepoState.result.hasLocalChanges) {
                                    if ($Force) {
                                        Write-Warning "Repo has local changes for $ScopeName - Stashing changes"
                                        $ApplyResult = Invoke-SNOWWebRequest @ApplyRequest
                                    }
                                    else {
                                        Write-Error "Repo has local changes for $ScopeName - Cannot apply remote changes without -Force" -ErrorAction Stop
                                    }
                                }
                                else {
                                    $ApplyResult = Invoke-SNOWWebRequest @ApplyRequest
                                }
                                
                                if ($ApplyResult.result.progressId) {
                                    Write-Information "Applying remote changes. Progress ID: $($ApplyResult.result.progressId)"
                                    Wait-SNOWDevStudioTransaction -ProgressId $ApplyResult.result.progressId
                                }
                            }
                            else {
                                Write-Information "No remote changes to apply for $ScopeName"
                                return $RefreshResult
                            }
                        }
                        else {
                            return $RefreshResult 
                        }
                    }
                    else {
                        Write-Error "Failed to refresh branch for $ScopeName - $($RefreshBranchResponse.result)"
                    }
                }
            }
        }
    }
}
