function ConvertTo-BatchRequest {
    param(
        [Parameter()]
        [string]
        $URI,
        [Parameter()]
        [string]
        [ValidateSet('POST','PATCH')]
        $Method,
        [Parameter()]
        [string]
        $Body,
        [Parameter()]
        [Switch]
        $ExcludeResponseHeaders
    )

    if($URI -notmatch "(?<=service-now.com).*"){
        Throw "URI did not match https://*.service-now.com* format."
    }

    $BatchRequest = @{
        id                       = (new-guid).guid
        url                      = $Matches[0]
        method                   = $Method
        headers                  = @(
                                        @{  
                                            'name'  = 'Content-Type'
                                            'value' = 'application/json'
                                        },
                                        @{ 
                                            'name'  = 'Accept'
                                            'value' = 'application/json'
                                        }
                                    )
        exclude_response_headers = $ExcludeResponseHeaders.IsPresent
        body                     = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Body))
    }

    return $BatchRequest
}