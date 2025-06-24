function Assert-SNOWAuthWebSession() {
    [CmdletBinding()]
    param (
        [switch]$NewSession
    )
    
    if ($null -eq $script:SNOWAuth) {
        Write-Error "Please set ServiceNow authentication with Set-SNOWAuth" -ErrorAction Stop
    }
    $SessionState = Get-SNOWWebSessionState
        
    #? Validate session cookies - if they are invalid, attempt to fetch a NEW session.
    if ($SessionState.CookiesValid -eq $true -and !$SessionState.Expired -and (!$NewSession.IsPresent)) {
        Write-Verbose "PSSnow WebSession Cookies appear valid. Instance: $($SessionState.Instance) $($SessionState.NextCookieExpiration.ToString('yyyy-MM-dd HH:mm:ss'))"
        $script:SNOWAuth.SessionState = $SessionState
    }
    else {
        Write-Warning "Assert-SNOWAuthWebSession - Removing SNOWAuth.session and re-authenticating"
        $Script:SNOWAuth.session = $null
        $script:SNOWAuth.SessionState = $null
        $script:SNOWAuth.session = New-SNOWAuthWebSession
        if ($Script:SNOWAuth.session.valid) {
            $script:SNOWAuth.SessionState = Get-SNOWWebSessionState -ValidateSession
            Write-Information ("Web Session state: [{0}]" -f $script:SNOWAuth.SessionState.ValidationMessage)
        }
        else {
            $Script:SNOWAuth.session = $null
            $script:SNOWAuth.SessionState = $null
            Write-Warning "New-SNOWWebSession failed, falling back to Basic/OAuth"
        }
    } 
}