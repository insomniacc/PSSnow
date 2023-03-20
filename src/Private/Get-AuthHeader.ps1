function Get-AuthHeader {
    param()

    if($script:SNOWAuth.Type -eq "basic"){
        $authInfo = "$($script:SNOWAuth.Credential.Username):$($script:SNOWAuth.Credential.GetNetworkCredential().Password)"
        @{
            Authorization = "Basic " + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($authInfo))
        }
    }elseif($script:SNOWAuth.Type -eq "oauth"){
        @{
            Authorization = "Bearer $($script:SNOWAuth.token.access_token)"
        }
    }
}