function Set-SNOWUserPhoto {
    <#
    .SYNOPSIS
        Attaches a picture to a user record and updates the photo property
    .DESCRIPTION
        This function uses the Attachment API to upload a photo to a user record as a hidden attachment
    .OUTPUTS
        PSCustomObject. The full table record (requires -PassThru).
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWUserPhoto.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_AttachmentAPI.html&version=latest
    .EXAMPLE
        $User | Set-SNOWUserPhoto -filepath "C:\Temp\Bruce.jpg"
        Updates a user photo
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
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
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
        #? Check for existing user photo
        if(-not $AsBatchRequest.IsPresent){
            $ExistingPhotos = Get-SNOWAttachment -Query "table_sys_id=a52eb6cf47e52110d3e5fa8bd36d432a^file_name=photo^table_name=ZZ_YYsys_user"
            Foreach($Photo in $ExistingPhotos){
                $Photo | Remove-SNOWAttachment -Confirm:$false
            }
        }

        if($PSCmdlet.ShouldProcess($Sys_ID,"SET")){
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
}