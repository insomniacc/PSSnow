BeforeDiscovery {
    $ScriptRoot = $PSScriptRoot
    $ModulePath = "$ScriptRoot\..\src"
    try{
        Import-Module -Name PSScriptAnalyzer -ErrorAction Stop
    }catch{
        Write-Error "Please ensure PSScriptAnalyzer is installed as a module. $($_.exception.message)"
    }

    $PSAExceptions = (import-csv -Path "$ScriptRoot\PSA.Exceptions.csv").Rule

    # Get all scripts
    $Scripts = Get-ChildItem $ModulePath -Include *.ps1, *.psm1, *.psd1 -Recurse | Where-Object {
        $_.Name -notin @("Invoke-Parallel.ps1")
    }

    # Get PSScriptAnalyzer rules
    $Rules = Get-ScriptAnalyzerRule
    $Rules = $Rules | Where-Object {
        $_.RuleName -notin $PSAExceptions
    }
}

Describe "PSScriptAnalyzer Tests for <_.Name>" -Tag Build, ScriptAnalyzer -ForEach $Scripts {
    BeforeAll {
        $ScriptPath = $_.FullName
        $ScriptName = $_.Name

        # Only run for warning and error.
        $Severity = @{ Severity = 'Error', 'Warning' }
    }

    # There should be no recommendations for the current rule.
    It "Rule <_.RuleName> should have no recommndations for <ScriptName>" -TestCases $Rules {
        $AnalyserSplat = @{
            Path        = $ScriptPath
            IncludeRule = $_.RuleName
            Settings    = $Severity
        }
        (Invoke-ScriptAnalyzer @AnalyserSplat).Count | Should -Be 0
    }
}