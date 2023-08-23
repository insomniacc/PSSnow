param(
    [switch]
    $Test,
    [switch]
    $Documentation,
    [ValidateSet('Major','Minor','Patch')]
    [string]
    $BumpVersion = "Patch",
    [version]
    $SpecificVersion
)

$Scriptpath = $PSScriptRoot
$ModulePath = $Scriptpath + "\src"
$ProjectName = $Scriptpath | Split-Path -leaf
#Import-Module "$ModulePath\$ProjectName.psd1" -Force -ErrorAction Stop

if($Test.IsPresent){
    if($PSVersionTable.PSVersion.ToString() -ge 5.2){
        Write-Warning "These Pester tests currently are only written for & functional in 5.1, expect errors in PS Core."
    }

    Write-Host "Running PSScriptAnalyzer tests"
    $AnalyzerResults = Invoke-ScriptAnalyzer -Path $ModulePath -Recurse -Profile @{Severity = @('Error', 'Warning')} -ReportSummary
    if($AnalyzerResults){
        $AnalyzerResults
        Throw "ScriptAnalyzer found rules with Warning/Error that need to be addressed"
    }else{
        Write-Host "ScriptAnalyzer checks passed" -f Green
    }

    Write-Host "Running Pester tests"
    try{
        $MinimumVersion = 5.0.0
        Import-Module Pester -MinimumVersion $MinimumVersion -ErrorAction Stop
    }catch{
        Throw "Pester is not installed. Required minimum version: $MinimumVersion"
    }

    $PesterResults = Invoke-Pester -PassThru
    if($PesterResults.FailedCount -gt 0){
        Throw "$($PesterResults.FailedCount) Pester tests failed"
    }
}

if($Documentation.IsPresent){
    try{
        Import-Module -Name platyPS -ErrorAction Stop
    }catch{
        Throw "platyPS module is required. Please use 'Install-Module platyPS'"
    }

    if(test-path "$Scriptpath\docs\functions"){
        Get-ChildItem -Path "docs\functions" -Recurse | Remove-Item -Recurse -Force
    }else{
        New-Item "$Scriptpath\docs\functions" -ItemType Directory -Force | out-null
    }

    # Create docs with platyPS.
    $Markdown = ForEach($Command in (Get-Command -Module $ProjectName -CommandType Function)){
        $Link = "docs/functions/$($Command.Name).md" #repo relative path
        $NewMarkdownSplat = @{
            Command          = $Command.Name
            OutputFolder     = "docs/functions/"
            Encoding         = [System.Text.Encoding]::UTF8
            OnlineVersionUrl = $Link
            UseFullTypeName  = $true
            Force            = $true
        }
        New-MarkdownHelp @NewMarkdownSplat
    }


    # Make some minor adjustments to the output, input/output header fix & synatx highlighting
    Get-ChildItem -Path "$scriptpath\docs\functions" -Filter "*.md" -Recurse | Foreach-Object {
        $DocPath = $_.FullName
        $DocTitle = $_.Name.TrimEnd(".md")
        $StringDoc = Get-Content -Path $DocPath -Raw

        #Fix input/output
        $StringDoc = $StringDoc -replace "(## .*PUTS\r\n\r\n)### ", "`$1"

        #Powershell syntax highlighting
        $StringDoc = $StringDoc -replace "(### EXAMPLE \d)\r\n``````", "`$1`r`n``````powershell" | Set-Content `
            -Path $DocPath -Encoding utf8 -Force
    }
}

if($PSCmdlet.ParameterSetName -in @('Bump','Specific')){
    $ManifestPath = "$ModulePath\$ProjectName.psd1"
    $Manifest = Test-ModuleManifest $ManifestPath -ErrorAction Stop
    [System.Version]$version = $Manifest.Version

    if($PSCmdlet.ParameterSetName -eq "Bump"){
        [String]$NewVersion = switch ($BumpVersion){
            "Major" {
                New-Object -TypeName System.Version -ArgumentList ($version.Major, 0, 0)
            }
            "Minor" {
                New-Object -TypeName System.Version -ArgumentList ($version.Major, ($version.Minor+1), 0)
            }
            "Patch" {
                New-Object -TypeName System.Version -ArgumentList ($version.Major, $version.Minor, ($version.Build+1))
            }
        }
    }elseif($PSCmdlet.ParameterSetName -eq "Specific"){
        [String]$NewVersion = $SpecificVersion
    }

    Update-ModuleManifest -Path $ManifestPath -ModuleVersion $NewVersion
}