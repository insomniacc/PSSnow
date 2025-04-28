$ScriptRoot = $PSScriptRoot
$ModulePath = ($ScriptRoot | Split-Path -Parent) + '\src'
$ProjectName = $ScriptRoot | Split-Path -Parent | Split-Path -Leaf
Import-Module "$ModulePath\$ProjectName.psm1" -Force
$Global:SN_TEST_ENABLED = (![string]::IsNullOrEmpty($env:SN_TEST_INSTANCE)) -and
(![string]::IsNullOrEmpty($env:SN_TEST_USERNAME)) -and
(![string]::IsNullOrEmpty($env:SN_TEST_PASSWORD))
InModuleScope $ProjectName {
    BeforeAll {
        . "$PSScriptRoot\Helpers\WebTestHelpers.ps1"
        AssertTestSNOWAuth -SetAuth
    }
    
    Describe 'UpdateSet Integration Tests' -Skip:(-not $Global:SN_TEST_ENABLED) {
        BeforeAll {
            # Define paths for test files
            $SampleUpdateSetPath = "$PSScriptRoot\TestFiles\sample_update_set.xml"
            $SampleUpdateSetPath2 = "$PSScriptRoot\TestFiles\sample_update_set_2.xml"
            
            $TestUpdateSetName = "Test Import Set"
            
            # Store created resources for cleanup
            $script:CreatedResources = @{
                UpdateSets    = @()
                ExportedFiles = @()
            }
            Write-Host "Running PSSnow UpdateSet tests. Instance: $env:SN_TEST_INSTANCE"
        }
        
        
        
        Context 'Search-SNOWUpdateSet' -Tag 'Integration' {
            It 'Should retrieve update sets with no parameters' {
                $updateSets = Search-SNOWUpdateSet
                
                $updateSets | Should -Not -BeNullOrEmpty
                $updateSets.sys_update_set.Count | Should -BeGreaterThan 0
                $updateSets.sys_update_set[0].name | Should -Not -BeNullOrEmpty
                $updateSets.sys_update_set[0].sys_id | Should -Not -BeNullOrEmpty
            }
            It 'Should retrieve update sets with a specific name' {
                $env:SNOW_MOCK_TAG = 'SearchNoResults'
                $updateSets = Search-SNOWUpdateSet -Query "name=$TestUpdateSetName"
                $updateSets | Should -Not -BeNullOrEmpty
                $env:SNOW_MOCK_TAG = $null
            }
        }

        
        
        
        Context 'Import-SNOWUpdateSet' -Tag 'Integration' {
            BeforeAll {
                $script:ImportedUpdateSetSysId = $null
                $env:SNOW_MOCK_TAG = $null
            }
            AfterAll {
                # Clean up any test update sets
                foreach ($updateSetId in $script:CreatedResources.UpdateSets) {
                    try {
                        $null = Invoke-SNOWWebRequest -URI "api/now/table/sys_remote_update_set/$updateSetId" -Method DELETE -UseRestMethod
                    }
                    catch {
                        Write-Warning "Failed to clean up test update set: $updateSetId"
                    }
                }
                
                # Clean up any exported files
                foreach ($filePath in $script:CreatedResources.ExportedFiles) {
                    if (Test-Path $filePath) {
                        Remove-Item -Path $filePath -Force
                    }
                }
            }
            It 'Should import an update set from an XML file' {
                $env:SKIP_MOCKS = $null
                $env:SNOW_MOCK_TAG = 'ImportUpdateSet'
                $importResult = Import-SNOWUpdateSet -Path $SampleUpdateSetPath
                $script:ImportedUpdateSetSysId = $importResult.sys_id
                $script:CreatedResources.UpdateSets += $script:ImportedUpdateSetSysId
                $env:SNOW_MOCK_TAG = $null
                $env:SKIP_MOCKS = 'true'
                $importResult | Should -Not -BeNullOrEmpty
                $importResult.sys_id | Should -Not -BeNullOrEmpty
                $importResult.PSObject.Properties.Name | Should -Contain 'name'
                $env:SNOW_MOCK_TAG = 'SearchOneResult'
                $updateSets = Search-SNOWUpdateSet -Query "name=$TestUpdateSetName"
                $updateSets.sys_remote_update_set | Should -Not -BeNullOrEmpty
                # Store for cleanup
                $env:SNOW_MOCK_TAG = $null
            }
            
            It 'Should throw an error for invalid XML' {
                # Create an invalid XML file
                $invalidXmlPath = Join-Path -Path $TestDrive -ChildPath "invalid.xml"
                Set-Content -Path $invalidXmlPath -Value "<invalid>not a valid update set XML</invalid>"
                
                { Import-SNOWUpdateSet -Path $invalidXmlPath -ErrorAction Stop } | Should -Throw
            }
        }
        
        Context 'Start-SNOWUpdateSetPreview' -Tag 'Integration' {
            BeforeAll {
                $LocalUpdateSets = Get-SNOWObject -Table 'sys_update_set' -Query "name=$TestUpdateSetName^state=complete"
                if ($LocalUpdateSets) {
                    foreach ($updateSet in $LocalUpdateSets) {
                        try {
                            Write-Host "Cleaning up existing test update set: $($updateSet.sys_id)"
                            Start-SNOWUpdateSetBackOut -Sys_id $updateSet.sys_id -Confirm:$false | Wait-SNOWCICDProgress
                        }
                        catch {
                            Write-Warning "Failed to clean up test update set: $($updateSet.sys_id)"
                            Write-Warning $_
                        }
                    }
                }

                # Create an update set to modify
                $importResult = Import-SNOWUpdateSet -Path $SampleUpdateSetPath
                
                $importResult | Should -Not -BeNullOrEmpty
                $importResult.sys_id | Should -Not -BeNullOrEmpty
                $importResult.PSObject.Properties.Name | Should -Contain 'name'
                $importResult2 = Import-SNOWUpdateSet -Path $SampleUpdateSetPath2
                # Store for cleanup
                $script:ImportedUpdateSetSysId = $importResult.sys_id
                $script:CreatedResources.UpdateSets += $script:ImportedUpdateSetSysId
            }
            AfterAll {
                # Clean up any test update sets
                foreach ($updateSetId in $script:CreatedResources.UpdateSets) {
                    try {
                        Remove-SNOWUpdateSet -sys_id $updateSetId -Sys_class_name 'sys_remote_update_set' -Confirm:$false
                    }
                    catch {
                        Write-Warning "Failed to clean up test update set: $updateSetId"
                        Write-Warning $_
                    }
                }
                
                # Clean up any exported files
                foreach ($filePath in $script:CreatedResources.ExportedFiles) {
                    if (Test-Path $filePath) {
                        Remove-Item -Path $filePath -Force
                    }
                }
            }
            
            It 'Should start a preview normally' {
                $env:SNOW_MOCK_TAG = 'PreviewUpdateSet'
                $previewResult = Start-SNOWUpdateSetPreview -sys_id $script:ImportedUpdateSetSysId | Wait-SNOWCICDProgress
                $env:SNOW_MOCK_TAG = $null
                $previewResult | Should -Not -BeNullOrEmpty
                $previewResult.remote_update_set_id | Should -Not -BeNullOrEmpty
            }

            It 'Should start a preview normally and then commit' {
                $env:SNOW_MOCK_TAG = 'PreviewUpdateSet'
                $previewResult = Start-SNOWUpdateSetPreview -sys_id $script:ImportedUpdateSetSysId | Wait-SNOWCICDProgress
                $previewResult | Should -Not -BeNullOrEmpty
                $previewResult.remote_update_set_id | Should -Not -BeNullOrEmpty
                $env:SNOW_MOCK_TAG = 'CommitUpdateSet'
                $commitResult = Start-SNOWUpdateSetCommit -sys_id $script:ImportedUpdateSetSysId | Wait-SNOWCICDProgress
                $commitResult | Should -Not -BeNullOrEmpty
                # Since we're just getting the raw result now, not the wrapped object with UpdateSet property
                $commitResult.local_update_set_id | Should -Not -BeNullOrEmpty
                $commitResult.percent_complete | Should -Be 100
            }
        }
    }
}