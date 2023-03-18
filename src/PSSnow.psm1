using namespace System.Management.Automation
using namespace System.Management.Automation.Internal

$ErrorActionPreference = "Stop"

$ModulePath = $PSScriptRoot

$Private = Get-ChildItem (Join-Path $ModulePath Private) -Recurse -Filter *.ps1
$Public = Get-ChildItem (Join-Path $ModulePath Public) -Recurse -Filter *.ps1

#Dot source the functions
$Functions = @($Private;$Public).Foreach({
    [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8) + [System.Environment]::NewLine
})
. ([System.Management.Automation.ScriptBlock]::Create($Functions))

# Export public functions
Export-ModuleMember -Function $Public.BaseName -Alias *