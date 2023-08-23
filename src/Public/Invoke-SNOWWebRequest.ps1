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
        [object]$Body,
        [string]$ContentType,
        [string]$OutFile,
        [string]$InFile,
        [string]$TransferEncoding,
        [switch]$PassThru,
        [int]$WebCallTimeoutSeconds = $Script:SNOWAuth.WebCallTimeoutSeconds,
        [switch]$UseRestMethod
    )

    Begin {
        Assert-SNOWAuth

        if($URI -notlike "https://$($script:SNOWAuth.Instance).service-now.com*"){
            $PSBoundParameters.URI = "https://$($script:SNOWAuth.Instance).service-now.com/$URI"
        }

        # Timeout properties
        if($WebCallTimeoutSeconds -gt 0){
            if($PSVersionTable.PSVersion.ToString() -gt 7.3){
                $TimeoutSplat = @{
                    OperationTimeoutSeconds = $WebCallTimeoutSeconds
                }
            }else{
                $TimeoutSplat = @{
                    TimeoutSec = $WebCallTimeoutSeconds
                }
            }
        }else{
            $TimeoutSplat = @{}
        }

        # Proxy Auth
        $ProxyAuth = $script:SNOWAuth.ProxyAuth
        if($Headers){
            $PSBoundParameters.Headers = (Get-AuthHeader) + $Headers
        }else{
            $PSBoundParameters.Headers = (Get-AuthHeader)
        }

        # Remove all non standard properties from passthrough params
        [Void]$PSBoundParameters.Remove('WebCallTimeoutSeconds')
        [Void]$PSBoundParameters.Remove('UseRestMethod')

        # Removes GUI and increases performance
        $ProgressPreference = "SilentlyContinue"
    }

    Process {
       Do{
            try{
                if($UseRestMethod.IsPresent){
                    Invoke-RestMethod @PSBoundParameters @ProxyAuth @TimeoutSplat -UseBasicParsing -ErrorAction Stop
                }else{
                    Invoke-WebRequest @PSBoundParameters @ProxyAuth @TimeoutSplat -UseBasicParsing -ErrorAction Stop
                }
                break
            }catch{
                if($_.Exception.Response.StatusCode -eq 429){
                    
                    $RateLimitRule = $_.Exception.Response.Headers.GetValues("X-RateLimit-Rule") | Out-String
                    $RateLimitLimit = $_.Exception.Response.Headers.GetValues("X-RateLimit-Limit") | Out-String
                    
                    $ResetTime = $_.Exception.Response.Headers.GetValues("X-RateLimit-Reset") | Out-String
                    $UnixDate = get-date "1/1/1970"
                    $RateLimitResetTime = $UnixDate.AddSeconds($ResetTime).ToLocalTime()
                    $RateLimitResetDuration = New-TimeSpan -Start (get-date) -End $RateLimitResetTime

                    if($Script:SNOWAuth.HandleRatelimiting){
                        Write-Warning "Rate limited (Rule: $RateLimitRule), cooling off for $RateLimitResetDuration"
                        Start-Sleep $RateLimitResetDuration.TotalSeconds + 1
                    }else{
                        Write-Error "Rate limit hit (Rule: $RateLimitRule). Duration until reset: $RateLimitResetDuration. Use -HandleRateLimiting on Set-SNOWAuth to automatically wait and retry."
                        break
                    }
                }else{
                    throw
                }
            }
        }While($true)
    }
}