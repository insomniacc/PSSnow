function New-SNOWUser {
    [CmdletBinding()]
    param (
        $first_name,
        $middle_name,
        $last_name,
        [alias('Username')]
        $user_name,
        $employee_number,
        $email,
        $active,
        [Boolean]
        $locked_out,
        $Company,
        $Department,
        $Manager,
        [Boolean]
        $enable_multifactor_authn,
        [Boolean]
        $web_service_access_only,
        [alias('Business phone')]
        $phone,
        $mobile_phone,
        $password_needs_reset,
        $city,
        $title,
        $street,
        [string]
        $photo,
        $time_zone,
        [alias('Language')]
        $preferred_language
    )
    DynamicParam { Import-DefaultParams -TemplateFunction "New-SNOWObject" }

    Begin {
        $table = "sys_user"

        if($photo){
            #? Photo can either be a filepath or base64. We'll check and convert so that our end format is always base64
            if(Test-Path $Photo){
                $photo = Convert-ImageFileToBase64 -FilePath $photo    
            }else{
                try {
                    [Void][System.Convert]::FromBase64String($photo)
                } catch {
                    throw "Photo is either not a filepath, nor a base64 encoded string."
                }
            }

            #? photo requires a separate rest call, so we'll remove it from out bound parameters
            [void]$PSBoundParameters.Remove('photo')
        }
    }
    Process {
        $SysID = Invoke-SNOWTableCREATE -table $table -Parameters $PSBoundParameters
        if($Photo){
            #todo - consider if this is the best placement - still have to add oauth2 support.
            $Body = @{
                agent = "Posting a picture to a User Record"
                topic = "AttachmentCreator"
                name = "photo:image/jpeg"
                source = "sys_user:$SysID"
                payload = $photo
            } | convertto-json -Compress
            $Response = Invoke-RestMethod -Method POST -Uri "https://$($script:SNOWAuth.instance).service-now.com/api/now/table/ecc_queue" -Body $Body -ContentType "Application/Json" -Credential $script:SNOWAuth.Credential
        }
        
    }
}