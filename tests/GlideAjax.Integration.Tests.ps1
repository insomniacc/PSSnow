$ScriptRoot = $PSScriptRoot
$ModulePath = ($ScriptRoot | Split-Path -Parent) + '\src'
$ProjectName = $ScriptRoot | Split-Path -Parent | Split-Path -Leaf
Import-Module "$ModulePath\$ProjectName.psm1" -Force

InModuleScope $ProjectName {
    Describe 'GlideAjax' -Skip:(
        ([string]::IsNullOrEmpty($env:SN_TEST_INSTANCE)) -or
        ([string]::IsNullOrEmpty($env:SN_TEST_USERNAME)) -or
        ([string]::IsNullOrEmpty($env:SN_TEST_PASSWORD))
    ) {
        BeforeAll {
            . "$PSScriptRoot\Helpers\WebTestHelpers.ps1"
            Write-Host "Running Integration tests against instance: $env:SN_TEST_INSTANCE"
            AssertTestSnowAuth -SetAuth
        }
        BeforeEach {
            $env:SNOW_MOCK_TAG = $null
        }          

        Context 'Invoke-SNOWGlideAjax' -Tag 'Integration' {
            It 'Should return a valid response' {
                $env:SNOW_MOCK_TAG = 'Invoke-SNOWGlideAjax'
                Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $Script:TEST_SN_CREDENTIALS -UseWebSession
                $TestAjaxParams = [hashtable]@{
                    'ni.nolog.x_referer'          = 'ignore'
                    x_referer                     = 'ignore'
                    sysparm_want_session_messages = 'true'
                    sysparm_processor             = 'global.UpdateSetAjax'
                    sysparm_type                  = 'getUpdateSets'
                }
                $Result = Invoke-SNOWGlideAjax -Params $TestAjaxParams
                $Result | Should -BeOfType 'PSCustomObject'
                # Should be a valid sys_id
                $Result.answer.currentSet | Should -Match '^[0-9a-f]{32}$'
            }
            It 'Should throw and error when -UseWebSession is not set' {
                Set-SNOWAuth -Instance $Script:TEST_SN_INSTANCE -Credential $Script:TEST_SN_CREDENTIALS
                $TestAjaxParams = [hashtable]@{
                    'ni.nolog.x_referer'          = 'ignore'
                    x_referer                     = 'ignore'
                    sysparm_want_session_messages = 'true'
                    sysparm_processor             = 'global.UpdateSetAjax'
                    sysparm_type                  = 'getUpdateSets'
                }
                { Invoke-SNOWGlideAjax -Params $TestAjaxParams } | Should -Throw 'GlideAjax requests require a valid WebSession and X-UserToken. Use Set-SNOWAuth with the -UseWebSession switch.'
            }
        }
    }
                    
}