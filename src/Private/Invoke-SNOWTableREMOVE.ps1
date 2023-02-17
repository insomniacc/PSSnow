function Invoke-SNOWTableREMOVE {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')]
    param (
        [Parameter(Mandatory)]
        [string]
        $table,
        [Parameter(Mandatory)]
        [hashtable]
        $Parameters
    )
    
    BEGIN {
        Assert-SNOWAuth
        $Parameters = Format-Hashtable -Hashtable $Parameters -KeysToLowerCase
        $BaseURL = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v2/table/$Table/"
        
        #todo support oauth
        $AuthSplat = @{Credential = $script:SNOWAuth.Credential}

        #$ProgressPreference = "SilentlyContinue"
    }
    
    PROCESS {
        try{
            $URI = "$BaseURL$($Parameters.sys_id)"
            if($PSCmdlet.ShouldProcess($table,"DELETE $($Parameters.sys_id)")){
                if($PSversiontable.PSEdition -eq "Core" -and $VerbosePreference -eq "Continue"){
                    Write-Verbose $URI
                }
                Invoke-RestMethod -Method "DELETE" -URI $URI @AuthSplat
            }
        }catch{
            Write-Error "$($_.Exception.Message) [$URI]"
        }
       
    }
    
    END {}
}