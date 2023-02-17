function Invoke-SNOWTableUPDATE {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [hashtable]
        $Parameters,
        [Parameter(Mandatory)]
        [string]
        $Table
    )
    
    BEGIN {
        Assert-SNOWAuth
        $BaseURL = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v2/table/$Table"
        $DefaultParameterList = "Set-SNOWObject" | Import-DefaultParams -AsStringArray
        $Parameters = Format-Hashtable -Hashtable $Parameters -KeysToLowerCase
        $UpdateParameters = $Parameters.GetEnumerator() | Where-Object {$_.Key -notin $DefaultParameterList}
        #todo support oauth
        $AuthSplat = @{Credential = $script:SNOWAuth.Credential}

        #Removes GUI and increases performance
        $ProgressPreference = "SilentlyContinue"
    }
    
    PROCESS {
        $URI = "$BaseURL/$($Parameters.sys_id)"

        #? Create BODY
        #Combine properties hashtable with any additional parameters
        if($Parameters.properties){
            $Body = $Parameters.properties
        }else{
            $Body = @{}
        }

        if($UpdateParameters){
            if($UpdateParameters.GetType().Name -eq "DictionaryEntry"){
                $Body.Add($UpdateParameters.Key,$UpdateParameters.Value)
            }else{
                Foreach($Property in $UpdateParameters.GetEnumerator()){
                    $Body.Add($Property.Key,$Property.Value)
                }
            }
            
        }

        #todo type conversions from additional parameters; datetimes, switch?, etc
        #todo support batch requests
        #if($Parameter.ContainsKey('AsBatchRequest')){

            #return batch request
        #}

        $Body = $Body | ConvertTo-Json -Depth 10 -Compress


        #? API Call
        try{
            
            if($PSversiontable.PSEdition -eq "Core" -and $VerbosePreference -eq "Continue"){
                Write-Verbose $URI
            }

            if($PSCmdlet.ShouldProcess($table,$Parameters.sys_id)){
                $Response = Invoke-RestMethod -Method PATCH -URI $URI -Body $Body @AuthSplat

                if($Parameters.Passthru.IsPresent){
                    Return $Response.Result
                }
            }
        }catch{
            Write-Error "$($_.Exception.Message) [$URI]"
        }
       
    }
}


