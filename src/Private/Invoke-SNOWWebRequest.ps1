function Invoke-SNOWWebRequest {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory)]
        [string]$URI,
        [ValidateSet(
            'Default',
            'Delete',
            'Get',
            'Head',
            'Merge',
            'Options',
            'Patch',
            'Post',
            'Put',
            'Trace'
        )]
        [string]$Method = "Get",
        [hashtable]$Headers,
        [timespan]$RateLimitTimeout,
        [object]$Body,
        [string]$ContentType,
        [string]$OutFile,
        [string]$InFile,
        [string]$TransferEncoding,
        [switch]$PassThru
    )

    Begin {
        $ProxyAuth = $script:SNOWAuth.ProxyAuth
        if($Headers){
            $PSBoundParameters.Headers = (Get-AuthHeader) + $Headers
        }else{
            $PSBoundParameters.Headers = (Get-AuthHeader)
        }

        if($RateLimitTimeout){
            $PSBoundParameters.Remove('RateLimitTimeout')
        }
    }

    Process {
        #todo work out what timeout / retry to add, should options for this be added into the script:SNOWAuth variable at set-snowauth stage?
       Do{
            try{
                Invoke-WebRequest @PSBoundParameters @ProxyAuth -erroraction Stop
            }catch{
                if($_.Exception.Response.StatusCode -eq "TooManyRequests"){
                    $RateLimitRule = $_.Exception.Response.Headers.GetValues("X-RateLimit-Rule") | Out-String
                    $RateLimitLimit = $_.Exception.Response.Headers.GetValues("X-RateLimit-Limit") | Out-String
                    
                    $ResetTime = $_.Exception.Response.Headers.GetValues("X-RateLimit-Reset") | Out-String
                    $UnixDate = get-date "1/1/1970"
                    $RateLimitResetTime = $UnixDate.AddSeconds($ResetTime).ToLocalTime()
                    $RateLimitResetDuration = New-TimeSpan -Start (get-date) -End $RateLimitResetTime
                }else{
                    throw
                }
            }

            #todo while statement needs adjusting, with relevant breaks inside the loop.
        }While($true)
    }

}



