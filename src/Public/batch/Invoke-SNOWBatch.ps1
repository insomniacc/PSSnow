function Invoke-SNOWBatch {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory,ParameterSetName='Requests')]
        $Requests,
        [Parameter(Mandatory,ParameterSetName='ScriptBlock')]
        [scriptblock]
        $ScriptBlock,
        [Parameter()]
        [int]
        $BatchSize = 150,
        [Parameter()]
        [int]
        [ValidateRange(1, 20)]
        $Threads = 1,
        [Parameter()]
        [switch]
        $PassThru
    )
    
    begin {
        Assert-SNOWAuth
        $URI = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v2/batch"
        
        # This will be used as an identifier across split batches
        $BatchGUID = (New-Guid).Guid

        if($PSBoundParameters.ContainsKey('ScriptBlock')){
            $InputScript = $ScriptBlock.ToString()
            if($InputScript -like "*-AsBatchRequest*"){
                Throw "The provided scriptblock cannot contain any commands with -AsBatchRequest already specified."
            }

            # Get a list of all the supported batch commands in the module
            $ModuleCommands = Get-Command -Module "PSServiceNow"
            $SupportedBatchCommands = ($ModuleCommands | Where-Object {$_.Parameters.ContainsKey('AsBatchRequest')}).Name

            # Get all PSServiceNow module commands within the scriptblock
            $ScriptBlockCommands = select-string "(?i)([\w]+-SNOW[\w]+)" -InputObject $InputScript -AllMatches

            # Append the AsBatchRequest parameter to all supported commands in the scriptblock 
            $ScriptBlockCommands = $ScriptBlockCommands.Matches.value | Sort-Object -Unique | Where-Object {$_ -in $SupportedBatchCommands}
            $ScriptBlockCommands.Foreach({
                $InputScript = $InputScript -replace $_,"$_ -AsBatchRequest"
            })
            
            #? Invoke the script and capture the output
            $Requests = Invoke-Expression -command $InputScript
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
                [pscustomobject]@{
                    batch_request_id = "BATCH $i ($BatchGuid)"
                    rest_requests = ($Requests | Select-Object -first $BatchSize -skip $Offset)
                }
            )
            $Offset += $BatchSize
        }

        if($PSCmdlet.ShouldProcess("$RequestCount Requests in $BatchCount Batches [$Threads Threads]", $PsCmdlet.MyInvocation.InvocationName)){

           
        }
        
    }
    
    end {
        
    }
}