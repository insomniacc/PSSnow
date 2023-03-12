function New-SNOWUserPhoto {
    <#
    .SYNOPSIS
        Creates a photo attachment for a user record and sets the photo property on that user
    .DESCRIPTION
        Using the ecc_queue table and the AttachmentCreator topic, a photo/image is associated to a user record
    .OUTPUTS
        PSCustomObject. The full table record (requires -PassThru).
    .LINK
        https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html
    .EXAMPLE
        New-SNOWUserPhoto -sysID "70c008e047a12110d3e5fa8bd36d436f" -filepath "C:\Users\Insomniac\Desktop\Bruce.jpg"
        Creates a new user called bruce wayne in the sys_user table
    #> 

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(ParameterSetName = 'Filepath', Mandatory)]
        [ValidateScript({
            if($_ | Test-Path){
                if($_ | Test-Path -PathType Leaf){
                    $filetypes = @('.jpg','.png','.bmp','.gif','.jpeg','.ico','.svg')
                    if([System.IO.Path]::GetExtension($_) -in $filetypes){
                        $true
                    }else{
                        Throw "Incorrect filetype, must be one of the following: $($filetypes -join ',')"
                    }
                }else{
                    Throw "Filepath cannot be a directory."
                }
            }else{
                Throw "Unable to find file."
            }
        })]
        [System.IO.FileInfo]
        $Filepath,
        [Parameter(Mandatory)]
        [alias('SysID')]
        [ValidateScript({
            if($_ -match "^[0-9a-f]{32}$"){
                $true
            }else{
                Throw "Must be a valid sys_id"
            }
        })]
        [string]
        #The sys_id of the user record in the sys_user table
        $Sys_ID,
        [Parameter()]
        [switch]
        $PassThru,
        [Parameter(DontShow)]
        [switch]
        $AsBatchRequest
    )
    
    process {
        $AttachmentSplat = @{
            File = $Filepath
            Sys_ID = $Sys_ID
            Sys_Class_Name = "ZZ_YYsys_user"
            PassThru = $PassThru.IsPresent
            AttachedFilename = "photo"
            AsBatchRequest = $AsBatchRequest.IsPresent
        }
        New-SNOWAttachment @AttachmentSplat
    }
}