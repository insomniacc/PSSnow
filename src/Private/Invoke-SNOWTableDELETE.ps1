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
        Assert-SNOWAuth
        $Parameters = Format-Hashtable -Hashtable $Parameters -KeysToLowerCase #todo remove this & test
        $BaseURL = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v2/table/$Table/"
        $AuthSplat = @{Headers = Get-AuthHeader}
        $ProxyAuth = $script:SNOWAuth.ProxyAuth

        #$ProgressPreference = "SilentlyContinue"
    }
    
    PROCESS {
        $URI = "$BaseURL$($Parameters.sys_id)"

        #? sysparm_query_no_domain
        if($Parameters.ContainsKey('RestrictDomain')){
            $URI = "$URI`?sysparm_query_no_domain=$($Parameters.RestrictDomain.ToString().ToLower())"
        }

        try{
            if($PSCmdlet.ShouldProcess($URI,'DELETE')){
                Invoke-RestMethod -Method "DELETE" -URI $URI @AuthSplat @ProxyAuth
            }
        }catch{
            Write-Error "$($_.Exception.Message) [$URI]"
        }
       
    }
}