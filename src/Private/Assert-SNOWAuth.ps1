function Assert-SNOWAuth() {
    [CmdletBinding()]
    param ()
    
    if($null -eq $script:SNOWAuth){
        Write-Error "Please set ServiceNow authentication with Set-SNOWAuth" -ErrorAction Stop
    }

    if($script:SNOWAuth.Type -eq "OAuth"){
        #todo check token expiry, renew if required
    }
}

