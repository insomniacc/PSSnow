function Invoke-SNOWTableGET {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [hashtable]
        $Parameters,
        [Parameter(Mandatory)]
        [string]
        $Table,
        [Parameter()]
        [int]
        $DefaultPagination = 1000
    )
    
    BEGIN {
        Assert-SNOWAuth
        $BaseURL = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v2/table/$Table"
        $DefaultParameterList = Import-DefaultParams -AsStringArray
        $Parameters = Format-Hashtable -Hashtable $Parameters -KeysToLowerCase
        $QueryParameters = $Parameters.GetEnumerator() | Where-Object {$_.Key -notin $DefaultParameterList}
        #todo support oauth
        $AuthSplat = @{Credential = $script:SNOWAuth.Credential}

        $Results = [System.Collections.ArrayList]@()
        #Removes GUI and increases performance
        $ProgressPreference = "SilentlyContinue"
    }
    
    PROCESS {
        #? sys_id OR sysparm_query
        if($Parameters.ContainsKey('sys_id')){
            #Direct Record Lookup
            $URI = "$BaseURL/$($Parameters.sys_id)?"
        }elseif($Parameters.ContainsKey('number')){
            #For example, a RITM, Incident or Task number.
            $URI = "$BaseURL`?sysparm_query=number=$($Parameters.number)"
        }elseif($Parameters.ContainsKey('query')){
            #String queries that can be copied directly from SNOW
            $URI = "$BaseURL`?sysparm_query=$($Parameters.query)"
        }else{
            #Queries that are generated by the parameters supplied on the inherited function (if any)
            $URI = ConvertTo-QueryString -BaseURL $BaseURL -QueryParameters $QueryParameters
        }

        #? sysparm_fields
        if($Parameters.ContainsKey('fields')){
            $URI = "$URI&sysparm_fields=$($Parameters.fields -join ',')"
        }

        #? sysparm_displayvalue
        if($Parameters.ContainsKey('displayvalue')){
            $URI = "$URI&sysparm_display_value=$($Parameters.displayvalue)"
        }

        #? sysparm_exclude_reference_link
        if($Parameters.ContainsKey('excludereferencelinks')){
            $URI = "$URI&sysparm_exclude_reference_link=$($Parameters.excludereferencelinks)"
        }

        #? sysparm_limit
        if($Parameters.ContainsKey('limit')){
            if($DefaultPagination -gt $Parameters.limit){
                $EnablePagination = $False
                $URI = "$URI&sysparm_limit=$($Parameters.limit)"
            }else{
                $EnablePagination = $True
                $URI = "$URI&sysparm_limit=$DefaultPagination"
            }
        }else{
            $EnablePagination = $True
            $URI = "$URI&sysparm_limit=$DefaultPagination"
        }

        #? sysparm_offset
        if($Parameters.ContainsKey('offset')){
            $EnablePagination = $False
            $URI = "$URI&sysparm_offset=$($Parameters['offset'])"
        }

        #? sysparm_query_no_domain
        if($Parameters.ContainsKey('restrictdomain')){
            $URI = "$URI&sysparm_query_no_domain=$($Parameters.RestrictDomain.ToString().ToLower())"
        }
        
        #? sysparm_query_no_domain
        if($Parameters.ContainsKey('SysParmView')){
            $URI = "$URI&sysparm_view=$($Parameters.SysParmView.ToString().ToLower())"
        }

        # sysparm_no_count - couldnt get this working, but figured there's going to be a stats function with the stats API anyway.
        # sysparm_query_category - not sure what the use case would be for this, havent included it
        # sysparm_suppress_pagination_header - has not been included for obvious reasons

        #? API Call
        try{
            if($EnablePagination){
                if($Parameters.ContainsKey('limit')){
                    For($Offset = 0; $Offset -lt $Parameters.limit; $Offset+=$DefaultPagination){
                        if($PSversiontable.PSEdition -eq "Core" -and $VerbosePreference -eq "Continue"){
                            Write-Verbose "$URI&sysparm_offset=$Offset"
                        }
                        $Response = (Invoke-RestMethod -uri "$URI&sysparm_offset=$Offset" @AuthSplat).Result
                        [void]$Results.Add($Response)
                    }
                    $Results = @($Results | ForEach-Object {$_}) | Select-Object -first $Parameters['limit']
                }else{
                    $Offset = 0
                    Do{
                        if($PSversiontable.PSEdition -eq "Core" -and $VerbosePreference -eq "Continue"){
                            Write-Verbose "$URI&sysparm_offset=$Offset"
                        }
                        $Response = Invoke-WebRequest -uri "$URI&sysparm_offset=$Offset" @AuthSplat -UseBasicParsing
                        [void]$Results.Add(($Response.content | ConvertFrom-Json).Result)
                        $Offset += $DefaultPagination
                    }While($Response.Headers.Link -like "*rel=`"next`"*")
                    $Results = @($Results | ForEach-Object {$_})
                }
            }else{
                if($PSversiontable.PSEdition -eq "Core" -and $VerbosePreference -eq "Continue"){
                    Write-Verbose $URI
                }
                $Results = (Invoke-RestMethod -URI $URI @AuthSplat).Result
            }            

            Return $Results
        }catch{
            Write-Error "$($_.Exception.Message) [$URI]"
        }
       
    }
    
    END {}
}