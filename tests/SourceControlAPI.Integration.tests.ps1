<#
.SYNOPSIS
    Integration tests for the sn_cicd and sn_devstudio functions in PSSnow.

.DESCRIPTION
    This script contains integration tests for the DevStudio module in ServiceNow.
    It tests the functionality of syncing applications, creating update sets. 
    These tests will be skipped if the following environment variables are not set:
    - SN_TEST_INSTANCE
    - SN_TEST_USERNAME
    - SN_TEST_PASSWORD
    - GITHUB_PAT - This should have write access to the repository as well since SN seems to check for it

#>
# PSScriptAnalyzer - TEST Secrets should be transient. Ignore this rule for the tests.
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
param()
$ScriptRoot = $PSScriptRoot
$ModulePath = ($ScriptRoot | Split-Path -Parent) + '\src'
$ProjectName = $ScriptRoot | Split-Path -Parent | Split-Path -Leaf
Import-Module "$ModulePath\$ProjectName.psm1" -Force

InModuleScope $ProjectName {
    Describe 'Source Control Integration Tests' {
        Context 'Sync-SNOWVCSApplication' -Skip:(
            ([string]::IsNullOrEmpty($env:SN_TEST_INSTANCE)) -or
            ([string]::IsNullOrEmpty($env:SN_TEST_USERNAME)) -or
            ([string]::IsNullOrEmpty($env:SN_TEST_PASSWORD)) -or 
            ([string]::IsNullOrEmpty($env:GITHUB_PAT))
        ) -Tag 'Integration' {
            BeforeAll {
                . "$PSScriptRoot\Helpers\WebTestHelpers.ps1"
                # Setup authentication if not already done
                AssertTestSnowAuth -SetAuth
                Assert-SNOWAuth
                Set-SNOWWebConcourseState -ScopeName 'global'
                $TestRequest = @{
                    Scope       = 'hax_1337_testapp'
                    RepoURL     = 'https://github.com/cherichita/servicenow-testapp.git'
                    Credential  = [pscredential]::new('git', (ConvertTo-SecureString -String $env:GITHUB_PAT -AsPlainText -Force))
                    BranchName  = 'blankslate'
                    DefaultUser = 'dimiter@todorov.ca'
                }
                
                function GetTestApp {
                    Get-SNOWObject -Table 'sys_app' -Query "name=TestApp^scope=$($TestRequest.Scope)"
                }

                function GetTestAppRecord {
                    Get-SNOWObject -Table 'sys_app' -Query "name=TestApp^scope=$($TestRequest.Scope)"
                }
            }
            BeforeEach {
                $env:SKIP_MOCKS = 'true'
                $env:SNOW_MOCK_TAG = $null
            }

            
            It 'Should Sync the TEST App' {
                $env:SKIP_MOCKS = $null
                $env:SNOW_MOCK_TAG = 'Sync-SNOWVCSApplication'
                $Result = Sync-SNOWVCSApplication @TestRequest -ImportIfMissing -ApplyChanges
                $AppRecord = GetTestAppRecord
                $AppRecord | Should -Not -BeNullOrEmpty
                $AppRecord.sys_id | Should -Not -BeNullOrEmpty
            }

            It 'Should run a background script in the newly synchronized app' {
                $AppRecord = GetTestAppRecord
                $AppRecord | Should -Not -BeNullOrEmpty
                $AppRecord.sys_id | Should -Not -BeNullOrEmpty
                $GetCurrentAppScript = "gs.info(gs.getCurrentScopeName())"
                $ScriptResult = Invoke-SNOWBackgroundScript -ScriptContents "gs.info('Hello from the background script in the app: TestApp');${GetCurrentAppScript}" -Scope $AppRecord.sys_id
                $ScriptResult | Should -Not -BeNullOrEmpty
                Write-Host "$($ScriptResult.ScriptResponse)"
                $ScriptResult.ScriptResponse | Should -Not -BeNullOrEmpty
                $ScriptResult.ScriptResponse | Should -BeLike "*Hello from the background script in the app: TestApp*"
                $ScriptResult.ScriptResponse | Should -BeLike "*Script completed in scope $($TestRequest.Scope)*"
            }

            Context 'New-SNOWUpdateSet' -Tag 'Integration' {
                BeforeAll {
                    $UpdateSetName = "Test Update Set Scoped"
                    $ExistingUpdateSet = Get-SNOWObject -Table 'sys_update_set' -Query "name=$($UpdateSetName)"
                    if ($ExistingUpdateSet) {
                        Start-SNOWUpdateSetBackOut -Sys_Id $ExistingUpdateSet.sys_id -Confirm:$false
                    }
                }
                It 'Should create a new update set' {
                    $AppRecord = GetTestAppRecord
                    $UpdateSet = New-SNOWUpdateSet -Name $UpdateSetName -Description "Test Update Set Description" -ApplicationSysId $AppRecord.sys_id
                    $UpdateSet | Should -Not -BeNullOrEmpty
                    $UpdateSet.sys_id | Should -Not -BeNullOrEmpty
                    Set-SNOWWebConcourseState -ScopeName $AppRecord.scope
                    $ConcourseState = Set-SNOWWebConcourseState -UpdateSet $UpdateSet.sys_id
                    $ConcourseState.Current.currentUpdateSet.sysId | Should -BeExactly $UpdateSet.sys_id
                }
            }

            It 'Should Set-SNOWWebConcourseState' {
                $SessionState = Get-SNOWWebSessionState -ValidateSession
                $SessionState.Valid | Should -BeTrue
                $SessionState.StatusCode | Should -BeExactly 200
                # Switch to Global first
                Set-SNOWWebConcourseState -ScopeName 'global'

                $AppRecord = GetTestAppRecord
                $AppRecord | Should -Not -BeNullOrEmpty
                $AppRecord.sys_id | Should -Not -BeNullOrEmpty
                $ConcourseState = Set-SNOWWebConcourseState -ScopeName $AppRecord.scope
                #  = Get-SNOWWebConcourseState
                $ConcourseState.Current.currentApplication.sysId | Should -BeExactly $AppRecord.sys_id
            }

            It 'Should Sync the TEST App and apply remote changes' {
                $Result = Sync-SNOWVCSApplication @TestRequest -ApplyChanges
                $Result.status | Should -Be "2"
                Write-Verbose "Result: $($Result | ConvertTo-Json -Depth 5)"
            }

            It 'should register a temporary repository and then switch if there is no repo' {
                $CurrentApp = GetTestApp
                # Assuming we need to check for repository connection and re-sync if needed
                $Result = Sync-SNOWVCSApplication @TestRequest -ApplyChanges -Force
                $Result.status | Should -Be "2"
            }

            It 'should pull in the app - when the REPO config is removed.' {
                $RepoConfig = Get-SNOWObject -Table 'sys_repo_config' -Query "url=$($TestRequest.RepoURL)^"
                if ($RepoConfig) {
                    Write-Warning "Deleting RepoConfig: $($RepoConfig.sys_id)"
                    Remove-SNOWObject -Table 'sys_repo_config' -sys_id $RepoConfig.sys_id -Confirm:$false
                }
                # $CurrentApp = GetTestApp
                # $CurrentApp | Should -BeNullOrEmpty
                $Result = Sync-SNOWVCSApplication @TestRequest -ApplyChanges
                $Result.status | Should -Be "2"
            }
        }
    }
}