function Invoke-SNOWRestMethod {

    <#
    .SYNOPSIS
        A generic way to make rest calls to servicenow API's [deprecated]
    .DESCRIPTION
        A wrapper for Invoke-RestMethod that utilizes authentication set with Set-SNOWAuth [deprecated]
    .NOTES
        !This function is deprecated and has been left in for backward compatibility. Please use Invoke-SNOWWebRequest instead.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Invoke-SNOWRestMethod.md
    .EXAMPLE
        $Response = Invoke-SNOWRestMethod -uri "api/now/v2/table/sys_user?sysparm_limit=1"
    .EXAMPLE
        $Body = @{first_name="john";last_name="smith"} | ConvertTo-json
        $Headers = @{"Content-Type"="Application/Json"}
        $Response = Invoke-SNOWRestMethod -uri "api/now/v2/table/sys_user" -Method "POST" -Body $Body -Headers $Headers
    #>    

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $Uri,
        [Parameter()]
        [ValidateSet(
            'DEFAULT',
            'HEAD',
            'MERGE',
            'OPTIONS',
            'TRACE',
            'GET',
            'PATCH',
            'POST',
            'PUT',
            'DELETE'
        )]
        [string]
        $Method,
        [Parameter()]
        [object]
        $Body,
        [Parameter()]
        [Hashtable]
        $Headers   
    )

    Begin {}
    Process {
        $RestMethodSplat = @{
            URI     = $URI
            Headers = $Headers
        }

        if($Method){
            $RestMethodSplat['Method'] = $Method
        }

        if($Body){
            $RestMethodSplat['Body'] = $Body
        }
        
        Invoke-SNOWWebRequest -UseRestMethod @RestMethodSplat
    }
}