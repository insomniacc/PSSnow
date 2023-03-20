function Invoke-SNOWBatch {
    <#
    .SYNOPSIS
        Allows for multiple requests to be made via the ServiceNow Batch API
    .DESCRIPTION
        Supported table operations can be wrapped with this command, instead of calls being made, all the requests will be grouped and sent to the batch api to be processed in parallel.
        This lightens API usage but also speeds up much lager calls against lots of records.
    .INPUTS
        An array of 'requests'. These can be collected from supported commands by either issuing the -AsBatchRequest parameter or simply wrapping those commands with Invoke-SNOWBatch -scriptblock { <supported commands go here> }
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Invoke-SNOWBatch.md
    .LINK
        https://docs.servicenow.com/csh?topicname=batch-api.html&version=latest
    .EXAMPLE
        $Response = Invoke-SNOWBatch -scriptblock {
        1..500 | ForEach-Object {
                $num = $_
                $Properties = @{
                    user_name = "bruce.wayne$num"
                    title = "Director"
                    first_name = "Bruce"
                    last_name = "Wayne"
                    Department = "Finance"
                    active = $false
                    email = "Bruce$num@WayneIndustries.com"
                    employee_number = "0000$num"
                }
                New-SNOWUser @Properties -Verbose
            }
        }
        $Response.serviced_requests | Group-Object -Property status_text
        Creates 500 users in the sys_user table called bruce.wayne, instead of making 500 calls, the requests are split into batches of 150 (default) at a time.
    .EXAMPLE
        $Response = Invoke-SNOWBatch -scriptblock {
        1..100 | ForEach-Object {
                $num = $_
                $Properties = @{
                    user_name = "bruce.wayne$num"
                    title = "Director"
                    first_name = "Bruce"
                    last_name = "Wayne"
                    Department = "Finance"
                    active = $false
                    email = "Bruce$num@WayneIndustries.com"
                    employee_number = "0000$num"
                }
                New-SNOWUser @Properties -Verbose
            }
        } -BatchSize 50  -Parallel
        $Response.serviced_requests | Group-Object -Property status_text
        Creates 100 users in the sys_user table called bruce.wayne, only 2 API calls (batches) are made to do this, both in parallel.
    .EXAMPLE
        $UsersToDisable = Get-SNOWUser -active $true -department "Product Management"
        $SNOWRequests = $UsersToDisable | Set-SNOWUser -active $false -AsBatchRequest
        Invoke-SNOWBatch -Requests $SNOWRequests
        Gets all the active users from a specific department, creates requests (as an array) to disable them all, passes that array into the Invoke-SNOWBatch to make the calls via the Batch API.
    #> 

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory,ParameterSetName='Requests')]
        #Requests can be gathered from supporting commands with -AsBatchRequest
        $Requests,
        [Parameter(Mandatory,ParameterSetName='ScriptBlock')]
        [scriptblock]
        #This can be used to wrap supported commands in a scriptblock. Instead of making individual calls they will be automatically grouped and sent to the batch API.
        $ScriptBlock,
        [Parameter()]
        [int]
        #How many requests should go into each batch. Too high and the calls could timeout.
        $BatchSize = 150,
        [Parameter()]
        [switch]
        #Batch calls will be made in parallel
        $Parallel,
        [Parameter(DontShow)]
        [int]
        [ValidateRange(1, 20)]
        #How many parallel calls to make against the Batch API
        $Threads = 3
    )
    
    begin {
        Assert-SNOWAuth
        $URI = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v1/batch"
        
        # This will be used as an identifier across split batches
        $BatchGUID = (New-Guid).Guid
        
        $RestHeaders = Get-AuthHeader

        if($PSBoundParameters.ContainsKey('ScriptBlock')){
            $InputScript = $ScriptBlock.ToString()
            if($InputScript -like "*-AsBatchRequest*"){
                Throw "The provided scriptblock cannot contain any commands with -AsBatchRequest already specified."
            }

            # Get a list of all the supported batch commands in the module
            $ModuleCommands = Get-Command -Module "PSSnow"
            $SupportedBatchCommands = ($ModuleCommands | Where-Object {$_.Parameters.ContainsKey('AsBatchRequest')}).Name

            # Get all PSSnow module commands within the scriptblock
            $ScriptBlockCommands = select-string "(?i)([\w]+-SNOW[\w]+)" -InputObject $InputScript -AllMatches 
            $ScriptBlockCommands = $ScriptBlockCommands.Matches.value | Sort-Object -Unique | Where-Object {$_ -in $SupportedBatchCommands}
            if(-not $ScriptBlockCommands){
                Write-Warning "There are no batch supported commands in the provided script block."
                return
            }

            # Append the AsBatchRequest parameter to all supported commands in the scriptblock
            $ScriptBlockCommands.Foreach({
                $InputScript = $InputScript -replace $_,"$_ -AsBatchRequest"
            })
            
            #? Invoke the script and capture the output
            $InputScript = [scriptblock]::Create($InputScript)
            $Requests = $InputScript.Invoke()
        } 
    }
    
    process {
        #? Calculate how many batches are required
        $RequestCount = ($Requests | Measure-Object).count
        if($RequestCount -eq 0){ return }

        if($RequestCount -gt $BatchSize){
            $BatchCount = [Math]::Ceiling($RequestCount/$BatchSize)
        }else{
            $BatchCount = 1
        }

        #? Split the requests into batches
        $Batches = [System.Collections.ArrayList]@()
        $Offset = 0
        for($i=0;$i -lt $BatchCount;$i++){
            [void]$Batches.add(
                [PSCustomObject]@{
                    batch_request_id = "PSSnow BATCH $i ($BatchGuid)"
                    rest_requests = @($Requests | Select-Object -first $BatchSize -skip $Offset)
                }
            )
            $Offset += $BatchSize
        }
        
        if($PSCmdlet.ShouldProcess("$RequestCount Requests in $BatchCount Batches", $PsCmdlet.MyInvocation.InvocationName)){
            if($BatchCount -gt 1 -and $Parallel.IsPresent){
                $Batches | Invoke-Parallel -Throttle $Threads -Verbose:$False -ScriptBlock {
                    $Batch = $_
                    Write-Verbose "Submitting $($Batch.batch_request_id)"
                    $Body = $Batch | ConvertTo-JSON -Depth 10 -Compress

                    $RestMethodSplat = @{
                        URI = $Using:URI
                        Method = 'POST'
                        Body = $Body
                        ContentType = 'application/json'
                        Headers = $Using:RestHeaders
                        Verbose = $false
                    }
                    $Response = Invoke-RestMethod @RestMethodSplat

                    $Response.serviced_requests.Foreach({
                        $_.body = ConvertFrom-JSON -InputObject ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_.body)))
                        # Check status codes or status text?
                    })

                    if($Response.unserviced_requests){
                        Write-Warning "unserviced_requests were returned within $($Batch.batch_request_id)"
                        #todo handle these depending on the cause, if due to timeout or similar, pass back in as new batches.
                        #potentially could use recursion as long as there's a way to prevent infinite loops.
                    }

                    $Response
                }
            }else{
                foreach($Batch in $Batches){
                    Write-Verbose "Submitting $($Batch.batch_request_id)"
                    $Body = $Batch | ConvertTo-JSON -Depth 10 -Compress

                    $RestMethodSplat = @{
                        URI = $URI
                        Method = 'POST'
                        Body = $Body
                        ContentType = 'application/json'
                        Headers = $RestHeaders
                        Verbose = $false
                    }
                    $Response = Invoke-RestMethod @RestMethodSplat     
                    
                    $Response.serviced_requests.Foreach({
                        $_.body = ConvertFrom-JSON -InputObject ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_.body)))
                        # Check status codes or status text?
                    })

                    if($Response.unserviced_requests){
                        Write-Warning "unserviced_requests were returned within $($Batch.batch_request_id)"
                        #todo handle these depending on the cause, if due to timeout or similar, pass back in as new batches.
                        #potentially could use recursion as long as there's a way to prevent infinite loops.
                    }

                    $Response
                }
            }     
        }
    }
}