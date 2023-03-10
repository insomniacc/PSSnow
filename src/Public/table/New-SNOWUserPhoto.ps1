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

    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName = 'Filepath', Mandatory)]
        [ValidateScript({
            if(Test-Path $_){
                $filetypes = @('.jpg','.jpeg','.gif','.png')
                if([System.IO.Path]::GetExtension($_) -in $filetypes){
                    $true
                }else{
                    Throw "Incorrect filetype, must be one of the following: $($filetypes -join ',')"
                }
            }else{
                Throw "Filepath does not exist."
            }
        })]
        $Filepath,
        [Parameter(ParameterSetName = 'Base64', Mandatory)]
        [string]
        #A base64 encoded image string
        $Base64String,
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
    
    begin {
        $table = "ecc_queue"

        if($PsCmdlet.ParameterSetName -eq "Filepath"){
            $Base64String = Convert-ImageFileToBase64 -FilePath $Filepath
        }
    }
    
    process {
        $properties = @{
            agent = "Posting a picture to a User Record"
            topic = "AttachmentCreator"
            name = "photo:image/jpeg"
            source = "sys_user:$Sys_ID"
            payload = $Base64String
            PassThru = $PassThru
            AsBatchRequest = $AsBatchRequest
        }
        Invoke-SNOWTableCREATE -table "ecc_queue" -Parameters $properties
    }
}