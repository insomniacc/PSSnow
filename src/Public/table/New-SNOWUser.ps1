function New-SNOWUser {
    <#
    .SYNOPSIS
        Creates a sys_user record in SNOW
    .DESCRIPTION
        Creates a record in the sys_user table
    .NOTES
        Uses New-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s (-PassThru only).
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWUser.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        New-SNOWUser -Properties @{"<key>"="<value>"} -PassThru
        Creates a single record in sys_user and returns the new record with SysID
    #>   
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "")]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [boolean]
        $active,
        [Parameter()]
        [string]
        $building,
        [Parameter()]
        [string]
        $city,
        [Parameter()]
        [string]
        $company,
        [Parameter()]
        [string]
        $cost_center,
        [Parameter()]
        [alias('country_code')]
        [string]
        $country,
        [Parameter()]
        [string]
        $department,
        [Parameter()]
        [string]
        $email,
        [Parameter()]
        [string]
        $employee_number,
        [Parameter()]
        [string]
        $first_name,
        [Parameter()]
        [string]
        $gender,
        [Parameter()]
        [string]
        $home_phone,
        [Parameter()]
        [alias('prefix')]
        [string]
        $introduction,
        [Parameter()]
        [string]
        $last_name,
        [Parameter()]
        [string]
        $location,
        [Parameter()]
        [string]
        $manager,
        [Parameter()]
        [string]
        $middle_name,
        [Parameter()]
        [string]
        $mobile_phone,
        [Parameter()]
        [string]
        $name,
        [Parameter()]
        [string]
        $notification,
        [Parameter()]
        [boolean]
        $password_needs_reset,
        [Parameter()]
        [alias('business_phone')]
        [string]
        $phone,
        [Parameter()]
        [alias('language')]
        [string]
        $preferred_language,
        [Parameter()]
        [alias('province')]
        [string]
        $state,
        [Parameter()]
        [string]
        $street,
        [Parameter()]
        [string]
        $time_format,
        [Parameter()]
        [string]
        $time_zone,
        [Parameter()]
        [string]
        $title,
        [Parameter()]
        [alias('user_id')]
        [string]
        $user_name,
        [Parameter()]
        [alias('password')]
        [string]
        $user_password,
        [Parameter()]
        [boolean]
        $vip,
        [Parameter()]
        [boolean]
        $web_service_access_only,
        [Parameter()]
        [alias('zip___postal_code')]
        [string]
        $zip,
        [Parameter()]
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
        $photo
    )
    DynamicParam { Import-DefaultParamSet -TemplateFunction "New-SNOWObject" }

    Begin {
        $table = "sys_user"
    }
    Process {
        if($photo){
            <#
                Adding photos to a user record is done in a second API call to a different endpoint (attachment API),
                It's been added to this function for ease of use.
                It is not supported by batch API requests in this way, because we need to create the user first to get their sys_id in order to attach the photo.
                In this instance it would be best to make the calls separately by omitting the photo from New-SNOWUser and also running a separate batch with New-SNOWUserPhoto.
                If both -AsBatchRequest and -Photo are provided this will be highlighted in a warning message and the photo will not be set.
            #>         
            #? Photo requires a separate rest call, so we'll remove it from the bound parameters
            [void]$PSBoundParameters.Remove('photo')
        }

        if($PSBoundParameters.ContainsKey('user_password') -and -not $PSBoundParameters.ContainsKey('InputDisplayValue')){
            # This is required for setting encrypted fields
            $PSBoundParameters.add('InputDisplayValue',$True)
        }


        $Response = Invoke-SNOWTableCREATE -table $table -Parameters $PSBoundParameters -Passthru

        if($Response.sys_id -and $photo){
            Set-SNOWUserPhoto -SysID $Response.sys_id -filepath $photo
        }elseif($PSBoundParameters.AsBatchRequest.IsPresent -and $photo){
            Write-Warning "Ignoring 'photo' param. New-SNOWUser does not support the photo parameter while batching.`nPlease make a separate batch call with New-SNOWUserPhoto."
        }

        if($PSBoundParameters.PassThru.IsPresent -or $PSBoundParameters.AsBatchRequest.IsPresent){
            $Response
        }
    }
}