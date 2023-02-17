function Set-SNOWAuth {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Instance,
        [Parameter(Mandatory)]
        [pscredential]
        $Credential,
        [string]
        $ClientID,
        [string]
        $ClientSecret,
        [ValidateSet('Basic','OAuth')]
        $AuthType = 'Basic'
    )

    if([String]::IsNullOrWhiteSpace($Instance)){
        Write-Error "Instance cannot be an empty string" -ErrorAction stop
    }
    
    if($instance -like "https://*"){
        $instance = $instance.replace('https://','')
    }

    if($instance -like "*.service-now.com*"){
        $instance = $instance.split('.') | select -first 1
    }

    $script:SNOWAuth = @{
        Instance = $Instance
        Credential = $Credential
    }

    switch ($AuthType) {
        'basic' {
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