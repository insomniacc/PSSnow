function New-SNOWImport {
    <#
    .SYNOPSIS
        Sends a new record to the import API
    .DESCRIPTION
        The import API can be used to push data into staging tables with transform maps
    .EXAMPLE
        $Movies = import-csv -Path "C:\temp\movies.csv"
        $Imports = ForEach($Movie in $Movies){
            $MovieProperties = @{
                u_title = $Movie."Movie Title"
                u_director = $Movie.Director
                u_actor = $Movie."Lead Actor"
                u_genre = $Movie.Genre
            }
            New-SNOWImport -table "u_moviesimport" -properties $MovieProperties
        }
        $Imports.result | Group-Object status | Select Count,Name
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWImport.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_ImportSetAPI.html&version=latest
    #>

    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]
        $Table,
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateCount(1, [int]::MaxValue)]
        [hashtable]
        $Properties,
        [Parameter(DontShow)]
        [switch]$AsBatchRequest
    )

    Begin {
        Assert-SNOWAuth
        $BaseURL = "https://$($script:SNOWAuth.Instance).service-now.com/api/now/v1/import/"
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
                $ProxyAuth = $script:SNOWAuth.ProxyAuth
                Invoke-RestMethod -Method POST -URI $URI -Body $Body -ContentType "Application/Json" @AuthSplat @ProxyAuth
            }
        }catch{
            Write-Error "$($_.Exception.Message) [$URI]"
        }
    }
}