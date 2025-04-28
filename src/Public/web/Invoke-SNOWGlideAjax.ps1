<#
.SYNOPSIS
    Sends a GlideAjax request to a ServiceNow instance and returns the response synchronously.

.DESCRIPTION
    This function sends a GlideAjax request to a ServiceNow instance using the provided parameters.
    It requires a valid WebSession, which can be established using the `Set-SNOWAuth` function with the `-UseWebSession` switch.

.PARAMETER Params
    A hashtable containing the parameters for the GlideAjax request. 
    The `sysparm_processor` key is required.

.EXAMPLE
    $Params = @{
        'sysparm_processor' = 'global.UpdateSetAjax'
        'sysparm_type'      = 'getUpdateSets'
    }
    $Response = Invoke-SNOWGlideAjax -Params $Params

.NOTES
    - Requires a valid WebSession.
    - The `sysparm_processor` parameter is mandatory.
    - Returns a hashtable containing the raw response and parsed attributes.
    - Tries to destructure the response XML into a hashtable. The raw response is also returned for custom processing.

#>

function Invoke-SNOWGlideAjax {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$Params
    )

    # Ensure authentication is valid
    Assert-SnowAuth
    if (-not $Script:SNOWAuth.session) {
        Write-Error 'GlideAjax requests require a valid WebSession and X-UserToken. Use Set-SNOWAuth with the -UseWebSession switch.' -ErrorAction Stop
    }

    # Validate required parameter
    if (-not $Params.ContainsKey('sysparm_processor')) {
        Write-Error 'The "sysparm_processor" parameter is required for GlideAjax requests.' -ErrorAction Stop
    }

    # Prepare request parameters
    $RParams = @{
        URI         = 'xmlhttp.do'
        Method      = 'GET'
        ContentType = 'application/x-www-form-urlencoded'
        Body        = $Params
    }

    # Send the request
    $Result = Invoke-SNOWWebRequest @RParams
    $ResultXml = [xml]$Result.Content
    # Parse the response attributes into a hashtable
    $Out = @{}
    if ($ResultXml) {
        foreach ($Attr in $ResultXml.DocumentElement.Attributes) {
            $Out[$Attr.Name] = $Attr.Value
        }
    }
    if ($Out['error']) {
        Write-Error "Error in response: $($Out['error'])"
    }

    # Return the parsed response and raw response
    return @{
        Content           = $Result.Content
        StatusCode        = $Result.StatusCode
        StatusDescription = $Result.StatusDescription
        Headers           = $Result.Headers
        RawContent        = $Result.RawContent
        Answer            = $Out
        ResponseXml       = $ResultXml
    }
}