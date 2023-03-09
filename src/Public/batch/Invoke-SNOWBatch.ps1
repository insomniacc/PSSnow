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
        $Threads = 1,
        [Parameter()]
        [switch]
        $PassThru
    )
    
    begin {
        Assert-SNOWAuth
        $URI = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v2/batch"
        
        #This will be used as an identifier across all split batches
        $BatchGUID = (New-Guid).Guid

        # Get all the batch api supported commands
        if($PSBoundParameters.ContainsKey('ScriptBlock')){
            $ModuleCommands = Get-Command -Module "PSServiceNow"
            $SupportedBatchCommands = ($ModuleCommands | Where-Object {$_.Parameters.ContainsKey('AsBatchRequest')}).Name
        }
        # If there's need for exceptions they should be added here
        $ExcludedCommands = @() 
    }
    
    process {
        #Collect requests

        switch ($PsCmdlet.ParameterSetName) {
            "ScriptBlock" {
                # Get all PSServiceNow module commands within the scriptblock
                $ScriptBlockCommands = select-string "(?i)([\w]+-SNOW[\w]+)" -InputObject $ScriptBlock.ToString() -AllMatches
                # Pick out only those that are supported by the Batch API
                $ScriptBlockCommands = $ScriptBlockCommands.Matches.value | Sort-Object -Unique | Where-Object {$_ -in $SupportedBatchCommands -and $_ -notin $ExcludedCommands}

            }
            "Requests" {}
            Default { Write-Error "Parameter set is not defined" }
        }


        if($PSCmdlet.ShouldProcess("x Requests in x Batches [x Threads]", $PsCmdlet.MyInvocation.InvocationName)){
            
        }
        
    }
    
    end {
        
    }
}