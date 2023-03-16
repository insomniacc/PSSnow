#$Scriptpath = $PSScriptRoot
$Scriptpath = 'C:\Users\Insomniac\Documents\git\PSServiceNow'
$ModulePath = $Scriptpath + "\src"
$ProjectName = $Scriptpath | Split-Path -leaf
Import-Module "$ModulePath\$ProjectName.psd1" -Force -ErrorAction Stop


#? Tests


Invoke-ScriptAnalyzer -Path $ModulePath -Recurse -Profile @{
    Severity = @('Error', 'Warning')
    ExcludeRules = @(
        'PSShouldProcess'	#Used in top level functions and inherited down into nested functions where it's applied
        'PSAvoidUsingPlainTextForPassword'	 #Until i work out a better way to handle these it's in use within New-SNOWUser
        'PSAvoidUsingUsernameAndPasswordParams'	 #In use within New-SNOWUser - params match field names
        'PSReviewUnusedParameter'	 #Occasionally causes false flags
        'PSUseDeclaredVarsMoreThanAssignments' #Getting a false flag with this too
    )
}

write-verbose "Running Pester Tests"
Invoke-Pester #-Output Detailed


#? Docs
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

    #Powershell syntaxi highlighting
    $StringDoc = $StringDoc -replace "(### EXAMPLE \d)\r\n``````", "`$1`r`n``````powershell" | Set-Content `
        -Path $DocPath -Encoding utf8 -Force
}
