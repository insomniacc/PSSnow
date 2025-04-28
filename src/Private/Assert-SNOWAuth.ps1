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
}

