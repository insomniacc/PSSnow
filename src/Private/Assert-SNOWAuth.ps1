function Assert-SNOWAuth() {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int]
        # Expressed in seconds
        $OauthExpiryBuffer = 180
    )
    
    if($null -eq $script:SNOWAuth){
        Write-Error "Please set ServiceNow authentication with Set-SNOWAuth" -ErrorAction Stop
    }

    if($script:SNOWAuth.Type -eq "OAuth"){
        $CurrentTime = Get-Date
        $ExpiryTime = $script:SNOWAuth.Expires.AddSeconds(-$OauthExpiryBuffer)
        if($ExpiryTime -le $CurrentTime){
            $ProxyAuth = $script:SNOWAuth.ProxyAuth
            #? Get a new token
            $Body = @{
                grant_type="refresh_token"
                client_id = $script:SNOWAuth.ClientID
                refresh_token = $script:SNOWAuth.token.refresh_token
            }
            # If client secret is provided, add it to the body. Public clients can refresh tokens without a client secret.
            if ($script:SNOWAuth.ClientSecret) {
                $Body.client_secret = [System.Net.NetworkCredential]::new('dummy', $script:SNOWAuth.ClientSecret).Password
            }
            $Token = Invoke-RestMethod -Method POST -uri "https://$($Script:SNOWAuth.Instance).service-now.com/oauth_token.do" -Body $Body -Verbose:$false @ProxyAuth

            $script:SNOWAuth.token = $token
            $script:SNOWAuth.Expires = (get-date).AddSeconds($Token.expires_in)
        }
    }
    if ($script:SNOWAuth.session) {
        $SessionState = Get-SNOWWebSessionState
        
        #? Validate session cookies - if they are invalid, attempt to fetch a NEW session.
        if ($SessionState.CookiesValid -eq $true -and !$SessionState.Expired) {
            $script:SNOWAuth.SessionState = $SessionState
        }
        else {
            Write-Warning "PSSnow WebSession ValidationMessage: $($SessionState.ValidationMessage) - Removing SNOWAuth.session and re-authenticating"
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
                Write-Warning "Web login failed, falling back to basic authentication"
            }
        } 
    }
}

