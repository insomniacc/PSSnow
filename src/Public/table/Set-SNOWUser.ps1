function Set-SNOWUser {
    <#
    .SYNOPSIS
        Updates a sys_user record in SNOW
    .DESCRIPTION
        Updates a record from the sys_user table
    .NOTES
        Uses Set-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s (-PassThru only).
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWUser.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Set-SNOWUser -Sys_ID "<sys_id>" -Properties @{"<key>"="<value>"} -verbose
        Updates a specific record in the table sys_user
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
        [alias('enable_multifactor_authentication')]
        [boolean]
        $enable_multifactor_authn,
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
        [boolean]
        $locked_out,
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
        $zip
    )
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Set-SNOWObject" }

    Begin {
        $table = "sys_user"
    }
    Process {
        if($PSBoundParameters.ContainsKey('user_password') -and -not $PSBoundParameters.ContainsKey('InputDisplayValue')){
            # This is required for setting encrypted fields
            $PSBoundParameters.add('InputDisplayValue',$True)
        }

        Invoke-SNOWTableUPDATE -table $table -Parameters $PSBoundParameters
    }
}