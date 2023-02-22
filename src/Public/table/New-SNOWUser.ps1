function New-SNOWUser {
    [CmdletBinding()]
    param (
        [Parameter()]
        [alias('firstname')]
        [string]
        $first_name,
        [Parameter()]
        [alias('middlename')]
        [string]
        $middle_name,
        [Parameter()]
        [alias('lastname')]
        [string]
        $last_name,
        [Parameter()]
        [alias('Username')]
        [string]
        $user_name,
        [Parameter()]
        [alias('employeenumber')]
        [string]
        $employee_number,
        [Parameter()]
        [string]
        $email,
        [Parameter()]
        [boolean]
        $active,
        [Parameter()]
        [Boolean]
        $locked_out,
        [Parameter()]
        [string]
        $Company,
        [Parameter()]
        [string]
        $Department,
        [Parameter()]
        [string]
        $Manager,
        [Parameter()]
        [Boolean]
        $enable_multifactor_authn,
        [Parameter()]
        [Boolean]
        $web_service_access_only,
        [Parameter()]
        [alias('business_phone')]
        [string]
        $phone,
        [Parameter()]
        [string]
        $mobile_phone,
        [Parameter()]
        [boolean]
        $password_needs_reset,
        [Parameter()]
        [string]
        $city,
        [Parameter()]
        [string]
        $title,
        [Parameter()]
        [string]
        $street,
        [Parameter()]
        [string]
        $photo,
        [Parameter()]
        [string]
        $time_zone,
        [Parameter()]
        [alias('Language')]
        [string]
        $preferred_language
    )
    DynamicParam { Import-DefaultParams -TemplateFunction "New-SNOWObject" }

    Begin {
        $table = "sys_user"

        <#
            The passthru param caused some issue here due to the way params are passed to the private functions.
            Might be worth revising & refactoring at some point but this functions for now.
        #>

        if($PSBoundParameters.ContainsKey('PassThru')){
            $ReturnObject = $true
        }

        if($photo){
            #? Photo can either be a filepath or base64. We'll check and convert so that our end format is always base64
            if(Test-Path $Photo){
                $photo = Convert-ImageFileToBase64 -FilePath $photo    
            }else{
                try {
                    [Void][System.Convert]::FromBase64String($photo)
                } catch {
                    throw "Photo must be either a filepath or a base64 encoded string."
                }
            }

            #? photo requires a separate rest call, so we'll remove it from out bound parameters
            [void]$PSBoundParameters.Remove('photo')

            if(-not $PSBoundParameters.ContainsKey('PassThru')){
                [void]$PSBoundParameters.Add('PassThru',[switch]$true)
                $ReturnObject = $false
            }
        }
    }
    Process {          
        $Response = Invoke-SNOWTableCREATE -table $table -Parameters $PSBoundParameters
        if($photo){
            $properties = @{
                agent = "Posting a picture to a User Record"
                topic = "AttachmentCreator"
                name = "photo:image/jpeg"
                source = "sys_user:$($Response.sys_id)"
                payload = $photo
            }
            Invoke-SNOWTableCREATE -table "ecc_queue" -Parameters $properties
        }

        if($ReturnObject){
            $Response
        }        
    }
}