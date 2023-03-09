function New-SNOWUserPhoto {
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
        $Base64String,
        [Parameter(Mandatory)]
        [ValidateScript({
            if($_ -match "^[0-9a-f]{32}$"){
                $true
            }else{
                Throw "Must be a valid sys_id"
            }
        })]
        [string]
        $SysID,
        [Parameter()]
        [switch]
        $Passthru,
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
            source = "sys_user:$SysID"
            payload = $Base64String
            passthru = $Passthru
            AsBatchRequest = $AsBatchRequest
        }
        Invoke-SNOWTableCREATE -table "ecc_queue" -Parameters $properties
    }
}