function New-SNOWImport {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]
        $Table,
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateCount(1, [int]::MaxValue)]
        [hashtable]
        $Properties,
        [Parameter()]
        [switch]$PassThru,
        [Parameter(DontShow)]
        [switch]$AsBatchRequest
    )

    Begin {
        #Assert-SNOWAuth
        $BaseURL = "https://$($script:SNOWAuth.Instance).service-now.com/api/now/import/"
        $AuthSplat = @{Headers = Get-AuthHeader}
    }

    Process {
        $URI  = $BaseURL + $Table
        $Body = Format-Hashtable -Hashtable $Properties -KeysToLowerCase
        $Body = $Body | ConvertTo-Json -Depth 10 -Compress

        if($AsBatchRequest.IsPresent){
            return (ConvertTo-BatchRequest -URI $URI -Method 'POST' -Body $Body)
        }

        #? API Call
        try{
            if($PSCmdlet.ShouldProcess($URI,'POST')){
                Invoke-RestMethod -Method POST -URI $URI -Body $Body -ContentType "Application/Json" @AuthSplat
            }
        }catch{
            Write-Error "$($_.Exception.Message) [$URI]"
        }
    }
}