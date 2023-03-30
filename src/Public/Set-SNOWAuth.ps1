function Set-SNOWAuth {
    <#
    .SYNOPSIS
        Sets ServiceNow authentication in the current session.
    .DESCRIPTION
        Applies module scope authentication for PSSnow
    .EXAMPLE
        Set-SNOWAuth -Instance "InstanceName" -Credential (get-credential) -Verbose
        Applies basic authentication in the current session for instance 'InstanceName.service-now.com'
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWAuth.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_RESTAPI.html&version=latest
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding(DefaultParameterSetName = 'Basic')]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        #Instance name e.g dev123456
        $Instance,
        [Parameter(Mandatory, ParameterSetName = 'Basic')]
        [Parameter(Mandatory, ParameterSetName = 'OAuth')]
        [PSCredential]
        #Basic Auth
        $Credential,
        [Parameter(Mandatory, ParameterSetName = 'OAuth')]
        [string]
        #OAuth ClientID
        $ClientID,
        [Parameter(Mandatory, ParameterSetName = 'OAuth')]
        [SecureString]
        #OAuth ClientSecret
        $ClientSecret
    )

    if([String]::IsNullOrWhiteSpace($Instance)){
        Write-Error "Instance cannot be an empty string" -ErrorAction stop
    }
    
    if($instance -like "https://*"){
        $instance = $instance.replace('https://','')
    }

    if($instance -like "*.service-now.com*"){
        $instance = $instance.split('.') | Select-Object -first 1
    }
    
    #? Aliveness/Hibernation check for developer instances
    $response = Invoke-WebRequest -Uri "https://$Instance.service-now.com/stats.do" -ErrorAction Stop -Verbose:$false
    if($response -and $response.content -like "*Instance Hibernating page*"){
        Throw "This servicenow instance is hibernating. Please wake the instance up and use $($PSCmdlet.MyInvocation.MyCommand.Name) again."
    }

    $script:SNOWAuth = @{
        Instance = $Instance
    }

    switch ($PsCmdlet.ParameterSetName) {
        'Basic' {
            $script:SNOWAuth += @{
                type = "basic"
                Credential = $Credential
            }
        }
        'OAuth' {
            #? Get Token
            $Body = @{
                grant_type= "password"
                client_id = $ClientID
                client_secret = [System.Net.NetworkCredential]::new('dummy', $ClientSecret).Password
                username = $Credential.UserName
                password = $Credential.GetNetworkCredential().Password
            }
            try{
                $Token = Invoke-RestMethod -Method POST -uri "https://$Instance.service-now.com/oauth_token.do" -Body $Body -Verbose:$false -ErrorAction Stop
            }catch{
                try {
                    $ReturnedErrorMessage = ConvertFrom-Json $_.ErrorDetails.Message -ErrorAction Stop
                    Throw "Unable to obtain OAuth access token. Description: $($ReturnedErrorMessage.error_description)"
                } catch {
                    Throw $_.Exception.Message
                }
            }

            if($null -ne $Token -and ($Token | get-member).name -contains 'access_token'){
                $script:SNOWAuth += @{
                    ClientID = $ClientID
                    ClientSecret = $ClientSecret
                    Token = $Token
                    Expires = (get-date).AddSeconds($Token.expires_in)
                    Type = "oauth"
                }
            }else{
                Throw "A valid access token was not retrieved"
            }
        }
    }
    Write-Verbose "Servicenow $($PsCmdlet.ParameterSetName) authentication has been set for $Instance"
}