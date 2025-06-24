function Invoke-SNOWBackgroundScript {
    <#
    .SYNOPSIS
    Executes a background script in the ServiceNow instance.
    
    .DESCRIPTION
    Executes a background script in the ServiceNow instance and returns the response.
    
    .PARAMETER ScriptContents
    The contents of the script to execute.
    
    .PARAMETER Scope
    The scope in which to execute the script. Default is 'global'.
    
    .PARAMETER NoRetry
    If specified, the function will not retry with a new session if the first attempt fails.
    
    .EXAMPLE
    Invoke-SNOWBackgroundScript -ScriptContents 'gs.print("Hello World")'
    
    .EXAMPLE
    Invoke-SNOWBackgroundScript -ScriptContents 'gs.print("App Scope Script")' -Scope 'x_myapp_scope'
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$ScriptContents,
        
        [Parameter(Mandatory = $false)]
        [string]$Scope = 'global'
    )
    
    Assert-SNOWAuthWebSession
    $Session = Get-SNOWWebSessionState -ValidateSession -ErrorAction Stop
    $ConcourseState = Get-SNOWWebConcourseState
    $ScopeSysId = $ConcourseState.ConcourseList.availableApplications | 
    Where-Object { ($_.scopeName -eq $Scope) -or ($_.sysId -eq $Scope) } | 
    Select-Object -ExpandProperty sysId
    
    if($Scope -eq 'global'){
        $ScopeSysId = 'global'
    }
    
    
    $RequestParams = @{
        URI           = '/sys.scripts.do'
        Method        = 'POST'
        # ContentType = 'application/x-www-form-urlencoded'
        Body          = @{
            script                    = "$ScriptContents"
            sysparm_ck                = $Session.SecurityToken
            runscript                 = 'Run script'
            sys_scope                 = $ScopeSysId
            record_for_rollback       = 'true'
            quota_managed_transaction = 'on'
        }
        UseRestMethod = $false
    }
    $Response = Invoke-SNOWWebRequest @RequestParams
    return @{
        Format         = 'json'
        ScriptResponse = [System.Web.HttpUtility]::HtmlDecode($Response.Content) -replace '<BR/>', "`n"
    }
}
