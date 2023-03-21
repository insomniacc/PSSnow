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
        $CurrentTime = (get-date).AddSeconds(-$OauthExpiryBuffer)
        if($script:SNOWAuth.Expires -le $CurrentTime){
            #? Get a new token
            $Body = @{
                grant_type="refresh_token"
                client_id = $script:SNOWAuth.ClientID
                client_secret = [System.Net.NetworkCredential]::new('dummy', $script:SNOWAuth.ClientSecret).Password
                refresh_token = $script:SNOWAuth.token.refresh_token
            }
            $Token = Invoke-RestMethod -Method POST -uri "https://$($Script:SNOWAuth.Instance).service-now.com/oauth_token.do" -Body $Body

            $script:SNOWAuth.token = $token
            $script:SNOWAuth.Expires = (get-date).AddSeconds($Token.expires_in)
        }
    }
}

