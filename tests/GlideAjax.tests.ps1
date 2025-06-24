# PSScriptAnalyzer - TEST Secrets should be transient. Ignore this rule for the tests.
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
param()
$ScriptRoot = $PSScriptRoot
$ModulePath = ($ScriptRoot | Split-Path -Parent) + "\src"
$ProjectName = $ScriptRoot | Split-Path -Parent | Split-Path -Leaf
Import-Module "$ModulePath\$ProjectName.psd1" -Force -ErrorAction Stop

InModuleScope $ProjectName {
    Describe "Invoke-SNOWGlideAjax" {
        BeforeAll {
            # Mocked responses for GlideAjax
            $ValidResponse = [xml]@"
<xml answer="+1%20%28416%29%20867-5309,North%20America,1%2C1%2Cfalse" sysparm_max="15" sysparm_name="process" sysparm_processor="global.PhoneNumberFormatter" />
"@
            $InvalidResponse = [xml]@"
<xml error="Invalid request" />
"@

            $ValidGetUpdateSetResponse = [xml]@'
<?xml version="1.0" encoding="UTF-8"?><xml currentSet="5c40a8bf83bc2a10f2dbcac6feaad318" sysparm_max="15" sysparm_processor="global.UpdateSetAjax" sysparm_type="getUpdateSets"><item label="Default [Global]" value="692733225cc022105590c762d23e63b1"/><item label="Test Import Set Old [Global]" value="5c40a8bf83bc2a10f2dbcac6feaad318"/></xml>
'@

            # Mock authentication
            $Username = 'DummyUsername'
            $Password = 'DummyPassword'
            $Instance = 'DummyInstance'
            $SSPassword = $Password | ConvertTo-SecureString -AsPlainText -Force
            $Script:Credential = New-Object PSCredential ($Username, $SSPassword)
            $Script:SNOWAuth = @{
                Instance   = $Instance
                Credential = $Credential
                session    = @{
                    WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
                }
            }

            Mock -CommandName Assert-SnowAuth -MockWith {
                $Script:SNOWAuth.session = @{
                    WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
                }
            }

            # Mock Invoke-SNOWWebRequest
            Mock -CommandName Invoke-SNOWWebRequest -ParameterFilter { $URI -eq 'xmlhttp.do' -and $Method -eq 'GET' } -MockWith {
                param($URI, $Method, $ContentType, $Body)
                if ($Body['sysparm_processor'] -eq 'global.PhoneNumberFormatter') {
                    @{
                        Content     = $ValidResponse.OuterXml
                        RawResponse = $ValidResponse
                        StatusCode  = 200
                        Headers     = @{
                            'Content-Type' = 'application/xml'
                        }
                    }
                }
                elseif ($Body['sysparm_processor'] -eq 'global.UpdateSetAjax') {
                    @{
                        Content     = $ValidGetUpdateSetResponse.OuterXml
                        RawResponse = $ValidGetUpdateSetResponse
                        StatusCode  = 200
                        Headers     = @{
                            'Content-Type' = 'application/xml'
                        }
                    }
                } 
                else {
                    @{
                        Content     = $InvalidResponse.OuterXml
                        RawResponse = $InvalidResponse
                        StatusCode  = 200
                        Headers     = @{
                            'Content-Type' = 'application/xml'
                        }
                    }
                }
            }
        }

        Context "Valid GlideAjax Request" -Tag "Unit" {
            It "Should return a valid response when sysparm_processor is provided" {
                $Params = @{
                    'sysparm_processor' = 'global.PhoneNumberFormatter'
                    'sysparm_type'      = 'formatPhoneNumber'
                }
                $Result = Invoke-SNOWGlideAjax -Params $Params
                $Result | Should -BeOfType Hashtable
                # $Result.RawResponse | Should -BeOfType [xml]
                $Result.Answer['answer'] | Should -BeExactly '+1%20%28416%29%20867-5309,North%20America,1%2C1%2Cfalse'
                $Result.Answer['sysparm_max'] | Should -BeExactly '15'
            }

            It 'Should return a valid response when sysparm_processor is "global.UpdateSetAjax"' {
                $Params = @{
                    'sysparm_processor' = 'global.UpdateSetAjax'
                    'sysparm_type'      = 'getUpdateSets'
                }
                $Result = Invoke-SNOWGlideAjax -Params $Params
                $Result | Should -BeOfType Hashtable
                # $Result.RawResponse | Should -BeOfType [xml]
                $Result.Answer['currentSet'] | Should -BeExactly '5c40a8bf83bc2a10f2dbcac6feaad318'
                $Result.Answer['sysparm_max'] | Should -BeExactly '15'
            }
        }

        Context "Invalid GlideAjax Request" -Tag "Unit" {
            It "Should throw an error when sysparm_processor is missing" {
                $Params = @{
                    'sysparm_type' = 'formatPhoneNumber'
                }
                { Invoke-SNOWGlideAjax -Params $Params } | Should -Throw 'The "sysparm_processor" parameter is required for GlideAjax requests.'
            }

            It "Should return an error response for invalid sysparm_processor" {
                $Params = @{
                    'sysparm_processor' = 'invalidProcessor'
                }
                $Result = Invoke-SNOWGlideAjax -Params $Params -ErrorAction SilentlyContinue
                $Result | Should -BeOfType Hashtable
                $Result.ResponseXml | Should -BeOfType [xml]
                $Result.Answer['error'] | Should -BeExactly 'Invalid request'
            }

            It 'Should throw an error for invalid response' {
                $Params = @{
                    'sysparm_processor' = 'global.InvalidProcessor'
                }
                { Invoke-SNOWGlideAjax -Params $Params } | Should -Throw 'Error in response: Invalid request'
            }
        }

        Context "Authentication Validation" -Tag "Unit" {
            It "Should throw an error if WebSession is not set" {
                Mock -CommandName Assert-SnowAuth -MockWith {
                    $Script:SNOWAuth.session = $null
                }
                $Params = @{
                    'sysparm_processor' = 'global.PhoneNumberFormatter'
                }
                { Invoke-SNOWGlideAjax -Params $Params } | Should -Throw 'GlideAjax requests require a valid WebSession and X-UserToken. Use Set-SNOWAuth with the -UseWebSession switch.'
            }
        }
    }
}