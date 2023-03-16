function Invoke-SNOWTableCREATE {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [hashtable]
        $Parameters,
        [Parameter(Mandatory)]
        [string]
        $Table,
        [Parameter()]
        [switch]
        $PassThru
    )
    
    BEGIN {
        Assert-SNOWAuth
        $URI = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v2/table/$Table"
        $DefaultParameterList = Import-DefaultParamSet -TemplateFunction "New-SNOWObject" -AsStringArray -IncludeCommon
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
        $Body = $Body | ConvertTo-Json -Depth 10 -Compress

        if($Parameters.AsBatchRequest.IsPresent){
            return (ConvertTo-BatchRequest -URI $URI -Method 'POST' -Body $Body)
        }

        #? API Call
        try{
            if($PSCmdlet.ShouldProcess($URI,'POST')){
                $Response = Invoke-RestMethod -Method POST -URI $URI -Body $Body -ContentType "Application/Json" @AuthSplat
                <#
                    Unlike the other CRUD private functions, CREATE has an additional PassThru
                    This is for granularity between the public and private functions as some CREATE actions may require the sys_id in order to perform other tasks, while not necessarily wanting to return output to the user
                    A good example of this is New-SNOWUser which features adding a photo to the user record (it's a second rest call after creation of the user)
                #>
                if($Parameters.PassThru.IsPresent -or $PassThru.IsPresent){
                    Return $Response.result
                }
            }
        }catch{
            Write-Error "$($_.Exception.Message) [$URI]"
        }
       
    }
}


