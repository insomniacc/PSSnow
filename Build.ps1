Invoke-ScriptAnalyzer -Path "$PSScriptRoot\src\" -Recurse -Profile @{
    Severity = @('Error', 'Warning')
    ExcludeRules = @(
        'PSShouldProcess'	#Used in top level functions and inherited down into nested functions where it's applied
        'PSAvoidUsingPlainTextForPassword'	 #Until i work out a better way to handle these it's in use within New-SNOWUser
        'PSAvoidUsingUsernameAndPasswordParams'	 #In use within New-SNOWUser - params match field names
        'PSReviewUnusedParameter'	 #Occasionally causes false flags
    )
} | Where-Object {$_.ScriptName -ne "Invoke-Parallel.ps1"}

write-verbose "Running Pester Tests"
Invoke-Pester #-Output Detailed