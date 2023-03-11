function New-SNOWAttachment {
    <#
    .SYNOPSIS
        Upload a file attachment to servicenow
    .DESCRIPTION
        Uploads a file as an attachment to a table record
    .NOTES
        System limitations on uploaded files, such as maximum file size and allowed attachment types are configured within ServiceNow. Default max filesize is 1024MB.
    .LINK
        https://developer.servicenow.com/dev.do#!/reference/api/tokyo/rest/c_AttachmentAPI
    .EXAMPLE
        $response  = Get-SNOWUser -user_name "bruce.wayne" | New-SNOWAttachment -file "C:\temp\test.txt" -PassThru
        Write-Host "File attached: $($response.download_link)"
        Attaches test.txt to the user_record for bruce.wayne and returns the download link.
    #>    

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [ValidateScript({
            if($_ | Test-Path){
                if($_ | Test-Path -PathType Leaf){
                    $true
                }else{
                    Throw "Filepath cannot be a directory."
                }
            }else{
                Throw "Unable to find file."
            }
        })]
        [System.IO.FileInfo]
        $File,
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [string]
        [alias('table_sys_id')]
        [alias('SysID')]
        $Sys_ID,
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [alias('table_name')]
        [alias('table')]
        [string]
        $Sys_Class_Name,
        [Parameter()]
        [switch]
        $PassThru
    )
    
    begin {
        Assert-SNOWAuth
        $BaseURL = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v1/attachment/file"
    }
    
    process {
        if($PSCmdlet.ShouldProcess($URI,'POST')){   
            $RestSplat = @{
                Headers    = @{
                    'Content-Type' = $MimeType
                    'Accept' = 'application/json'
                }
                Method     = 'POST'
                URI        = "$BaseURL`?file_name=$($File.name)&table_name=$Sys_Class_Name&table_sys_id=$Sys_ID"
                Body       = [System.IO.File]::ReadAllBytes($File)
                Credential = $Script:SNOWAuth.Credential
            }

            if($PSVersionTable.PSEdition -eq "Core"){
                $RestSplat += @{SkipHeaderValidation = $true}
                $RestSplat.Headers.'Content-Type' = "application/octet-stream"
                #I'm unsure currently of the best method to get the mime type on core.
                #Setting to a generic octet stream works for now, although I'm not sure if this can cause any other impact elsewhere with classifications.
            }else{
                $RestSplat.Headers.'Content-Type' = [System.Web.MimeMapping]::GetMimeMapping($File)
            }

            $Response = Invoke-RestMethod @RestSplat

            if($PassThru.IsPresent){
                Return $Response.Result
            }
        }
    }
}