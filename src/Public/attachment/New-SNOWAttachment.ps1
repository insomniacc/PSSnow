function New-SNOWAttachment {
    <#
    .SYNOPSIS
        Upload a file attachment to servicenow
    .DESCRIPTION
        Uploads a file as an attachment to a table record
    .NOTES
        System limitations on uploaded files, such as maximum file size and allowed attachment types are configured within ServiceNow. Default max file size is 1024MB.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWAttachment.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_AttachmentAPI.html&version=latest
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
        #The sys_id of the parent record to associate with the new attachment
        $Sys_ID,
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [alias('table_name')]
        [alias('table')]
        [string]
        #The table associated with the parent record
        $Sys_Class_Name,
        [Parameter()]
        [switch]
        #The newly created attachment record will be returned
        $PassThru,
        [Parameter(DontShow)]
        [string]
        #Used to alter the filename passed to servicenow.
        $AttachedFilename,
        [Parameter(DontShow)]
        [switch]
        $AsBatchRequest
    )
    
    begin {
        $BaseURL = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v1/attachment/file"
        $RestMethod = 'POST'
    }
    
    process {
        if($AttachedFilename){
            $Filename = $AttachedFilename
        }else{
            $Filename = $File.Name
        }
        $URI = "$BaseURL`?file_name=$Filename&table_name=$Sys_Class_Name&table_sys_id=$Sys_ID"

        try{
            if($PSVersionTable.PSEdition -eq "Core"){
                #I'm unsure currently of the best method to get the mime type on core.
                #Setting to a generic octet stream is generally accepted for anything but will cause classifications issues, e.g user photo uploads.
                #For now I've put a simple mapping based on ext
                $MimeType = switch ($File.Extension) {
                    '.aac' {'audio/aac'}
                    '.abw' {'application/x-abiword'}
                    '.arc' {'application/x-freearc'}
                    '.avif' {'image/avif'}
                    '.avi' {'video/x-msvideo'}
                    '.azw' {'application/vnd.amazon.ebook'}
                    '.bin' {'application/octet-stream'}
                    '.bmp' {'image/bmp'}
                    '.bz' {'application/x-bzip'}
                    '.bz2' {'application/x-bzip2'}
                    '.cda' {'application/x-cdf'}
                    '.csh' {'application/x-csh'}
                    '.css' {'text/css'}
                    '.csv' {'text/csv'}
                    '.doc' {'application/msword'}
                    '.docx' {'application/vnd.openxmlformats-officedocument.wordprocessingml.document'}
                    '.eot' {'application/vnd.ms-fontobject'}
                    '.epub' {'application/epub+zip'}
                    '.gz' {'application/gzip'}
                    '.gif' {'image/gif'}
                    '.htm' {'text/html'}
                    '.html' {'text/html'}
                    '.ico' {'image/vnd.microsoft.icon'}
                    '.ics' {'text/calendar'}
                    '.jar' {'application/java-archive'}
                    '.jpeg' {'image/jpeg'}
                    '.jpg' {'image/jpeg'}
                    '.js' {'text/javascript'}
                    '.json' {'application/json'}
                    '.jsonld' {'application/ld+json'}
                    '.mid' {'audio/midi'}
                    '.midi' {'audio/midi'}
                    '.mjs' {'text/javascript'}
                    '.mp3' {'audio/mpeg'}
                    '.mp4' {'video/mp4'}
                    '.mpeg' {'video/mpeg'}
                    '.mpkg' {'application/vnd.apple.installer+xml'}
                    '.odp' {'application/vnd.oasis.opendocument.presentation'}
                    '.ods' {'application/vnd.oasis.opendocument.spreadsheet'}
                    '.odt' {'application/vnd.oasis.opendocument.text'}
                    '.oga' {'audio/ogg'}
                    '.ogv' {'video/ogg'}
                    '.ogx' {'application/ogg'}
                    '.opus' {'audio/opus'}
                    '.otf' {'font/otf'}
                    '.png' {'image/png'}
                    '.pdf' {'application/pdf'}
                    '.php' {'application/x-httpd-php'}
                    '.ppt' {'application/vnd.ms-powerpoint'}
                    '.pptx' {'application/vnd.openxmlformats-officedocument.presentationml.presentation'}
                    '.rar' {'application/vnd.rar'}
                    '.rtf' {'application/rtf'}
                    '.sh' {'application/x-sh'}
                    '.svg' {'image/svg+xml'}
                    '.tar' {'application/x-tar'}
                    '.tif' {'image/tiff'}
                    '.tiff' {'image/tiff'}
                    '.ts' {'video/mp2t'}
                    '.ttf' {'font/ttf'}
                    '.txt' {'text/plain'}
                    '.vsd' {'application/vnd.visio'}
                    '.wav' {'audio/wav'}
                    '.weba' {'audio/webm'}
                    '.webm' {'video/webm'}
                    '.webp' {'image/webp'}
                    '.woff' {'font/woff'}
                    '.woff2' {'font/woff2'}
                    '.xhtml' {'application/xhtml+xml'}
                    '.xls' {'application/vnd.ms-excel'}
                    '.xlsx' {'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'}
                    '.xml' {'application/xml'}
                    '.xul' {'application/vnd.mozilla.xul+xml'}
                    '.zip' {'application/zip'}
                    '.3gp' {'video/3gpp'}
                    '.3g2' {'video/3gpp2'}
                    '.7z' {'application/x-7z-compressed'}
                    default {"application/octet-stream"}
                }
            }else{
                $MimeType = [System.Web.MimeMapping]::GetMimeMapping($File)
            }
        }catch{
            $MimeType = "application/octet-stream"
        }
        
        $Body = [System.IO.File]::ReadAllBytes($File)
        
        if($AsBatchRequest.IsPresent){
            if($URI -match "(?<=service-now.com).*"){
                return @{
                    id                       = (new-guid).guid
                    url                      = $Matches[0]
                    method                   = $RestMethod
                    headers                  = @(
                                                    @{  
                                                        'name'  = 'Content-Type'
                                                        'value' = $MimeType
                                                    },
                                                    @{ 
                                                        'name'  = 'Accept'
                                                        'value' = 'application/json'
                                                    }
                                                )
                    exclude_response_headers = $False
                    body                     = [convert]::ToBase64String($Body)
                }
            }
        }
        
        if($PSCmdlet.ShouldProcess($URI,$RestMethod)){
            $Headers = @{
                'Content-Type' = $MimeType
                'Accept' = 'application/json'
            }
            $RestSplat = @{
                Headers    = $Headers
                Method     = $RestMethod
                URI        = $URI
                Body       = $Body
            }

            if($PSVersionTable.PSEdition -eq "Core"){
                $RestSplat += @{SkipHeaderValidation = $true}
            }

            $Response = Invoke-SNOWWebRequest -UseRestMethod @RestSplat

            if($PassThru.IsPresent){
                Return $Response.Result
            }
        }
    }
}