function Invoke-SNOWTableCREATE {
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
        $URI = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v2/table/$Table"
        $DefaultParameterList = Import-DefaultParams -TemplateFunction "New-SNOWObject" -AsStringArray
        $CreateParameters = $Parameters.GetEnumerator() | Where-Object {$_.Key -notin $DefaultParameterList}
        #todo support oauth
        $AuthSplat = @{Credential = $script:SNOWAuth.Credential}

        #Removes GUI and increases performance
        $ProgressPreference = "SilentlyContinue"
    }
    
    PROCESS {
        #? sysparm_input_display_value
        if($Parameters.ContainsKey('InputDisplayValue')){
            $URI = "$URI`?sysparm_input_display_value=$($Parameters.InputDisplayValue.ToString().ToLower())"
        }

        #? Create BODY
        #Combine properties hashtable with any additional parameters
        if($Parameters.Properties){
            $Body = $Parameters.Properties
        }else{
            $Body = @{}
        }

        if($CreateParameters){
            if($CreateParameters.GetType().Name -eq "DictionaryEntry"){
                $Body.Add($CreateParameters.Key,$CreateParameters.Value)
            }else{
                Foreach($Property in $CreateParameters.GetEnumerator()){
                    $Body.Add($Property.Key,$Property.Value)
                }
            }
        }

        $Body = Format-Hashtable -Hashtable $Body -KeysToLowerCase

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

            if($PSCmdlet.ShouldProcess($Table)){
                $Response = Invoke-RestMethod -Method POST -URI $URI -Body $Body -ContentType "Application/Json" @AuthSplat
                if($Parameters.ContainsKey('PassThru')){
                    Return $Response.result
                }
            }
        }catch{
            Write-Error "$($_.Exception.Message) [$URI]"
        }
       
    }
}


