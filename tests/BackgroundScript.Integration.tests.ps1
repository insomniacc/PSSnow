$ScriptRoot = $PSScriptRoot
$ModulePath = ($ScriptRoot | Split-Path -Parent) + '\src'
$ProjectName = $ScriptRoot | Split-Path -Parent | Split-Path -Leaf
Import-Module "$ModulePath\$ProjectName.psm1" -Force
$Global:SN_TEST_ENABLED = (![string]::IsNullOrEmpty($env:SN_TEST_INSTANCE)) -and
(![string]::IsNullOrEmpty($env:SN_TEST_USERNAME)) -and
(![string]::IsNullOrEmpty($env:SN_TEST_PASSWORD))
if ($Global:SN_TEST_ENABLED) {
    
}
InModuleScope $ProjectName {
    Describe 'BackgroundScript' -Skip:(-not $Global:SN_TEST_ENABLED) {
        BeforeAll {
            . "$PSScriptRoot\Helpers\WebTestHelpers.ps1"
            Write-Host "Running BackgroundScript Integration tests against instance: $env:SN_TEST_INSTANCE"
            AssertTestSnowAuth -SetAuth
        }
        BeforeEach {
            $env:SNOW_MOCK_TAG = $null
        }          

        Context 'Invoke-SNOWBackgroundScript' -Tag 'Integration' {
            It 'should execute a background script successfully' {
                $TestGuid = [guid]::NewGuid().ToString()
                $ScriptContents = "gs.info('Executing PSSnow Test {0}')" -f $TestGuid
                $Response = Invoke-SNOWBackgroundScript -ScriptContents $ScriptContents
                $Response | Should -BeOfType 'PSCustomObject'
                $Response.ScriptResponse | Should -BeLike "*$TestGuid*"
            }

            It 'should execute a background script with a timeout' {
                $TestGuid = [guid]::NewGuid().ToString()
                $ScriptContents = "gs.info('Executing PSSnow Test {0}')" -f $TestGuid
                $Response = Invoke-SNOWBackgroundScript -ScriptContents $ScriptContents
                $Response | Should -BeOfType 'PSCustomObject'
                $Response.ScriptResponse | Should -BeLike "*$TestGuid*"
            }
        }
    }
                    
}