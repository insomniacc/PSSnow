function Set-SNOWAuth {
    <#
    .SYNOPSIS
        Sets ServiceNow authentication in the current session.
    .DESCRIPTION
        Applies module scope authentication for PSServiceNow
    .EXAMPLE
        Set-SNOWAuth -Instance "dev123456" -Credential (get-credential) -Verbose
        Applies authentication in the current session for instance 'dev123456.service-now.com'
    #>

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        #Instance name e.g dev123456
        $Instance,
        [Parameter(Mandatory, ParameterSetName = 'Basic')]
        [PSCredential]
        #Basic Auth
        $Credential,
        [Parameter(ParameterSetName = 'OAuth')]
        [string]
        #OAuth ClientID
        $ClientID,
        [Parameter(ParameterSetName = 'OAuth')]
        [string]
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

    if($PSCmdlet.ShouldProcess("$instance.service-now.com","Set Auth")){
        $script:SNOWAuth = @{
            Instance = $Instance
            Credential = $Credential
        }

        switch ($PsCmdlet.ParameterSetName) {
            'Basic' {
                $script:SNOWAuth += @{
                    type = "basic"
                }
            }
            'OAuth' {
                #todo get initial token & expiry time, add to auth object - create function for this
                $script:SNOWAuth += @{
                    ClientID = $ClientID
                    ClientSecret = $ClientSecret
                    Type = "OAuth"
                }
            }
        }
        Write-Verbose "Servicenow authentication has been set for $Instance"
    }
}