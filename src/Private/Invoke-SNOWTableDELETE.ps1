function Invoke-SNOWTableDELETE {
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
        $Parameters = Format-Hashtable -Hashtable $Parameters -KeysToLowerCase
        $BaseURL = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v2/table/$Table/"
    }
    
    PROCESS {
        $URI = "$BaseURL$($Parameters.sys_id)"

        #? sysparm_query_no_domain
        if($Parameters.ContainsKey('RestrictDomain')){
            $URI = "$URI`?sysparm_query_no_domain=$($Parameters.RestrictDomain.ToString().ToLower())"
        }
        
        try{
            if($PSCmdlet.ShouldProcess($URI,'DELETE')){
                Invoke-SNOWWebRequest -UseRestMethod -Method "DELETE" -URI $URI
            }
        }catch{
            Write-Error "$($_.Exception.Message) [$URI]"
        }
       
    }
}