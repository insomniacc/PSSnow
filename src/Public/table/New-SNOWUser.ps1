function New-SNOWUser {
    <#
    .SYNOPSIS
        Creates a new servicenow user record
    .DESCRIPTION
        Creates a record in the sys_user table
    .OUTPUTS
        PSCustomObject. The full table record (requires -passthru).
    .LINK
        https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html
    .EXAMPLE
        $Properties = @{
            user_name = "bruce.wayne"
            title = "Director"
            first_name = "Bruce"
            last_name = "Wayne"
            department = "Finance"
            email = "Bruce@WayneIndustries.com"
        }
        New-SNOWUser @Properties -PassThru
        Creates a new user called bruce wayne in the sys_user table
    #> 

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

        if($photo){
            <#
                Adding photos to a user record is done in a second API call to a different endpoint,
                So technically it's a separate thing all together, but it's something you exact should be available when creating a user
                I've added it as a feature here for usability.
                It is not supported by batch API requests in this way, because we need to create the user first to get their sys_id in order to attach the photo.
                In this instance it would be best to make the calls separately by omitting the photo from New-SNOWUser and also running a separate batch with New-SNOWUserPhoto.
                If both -AsBatchRequest and -Photo are provided this will be highlighted in a warning message and the photo will not be set.
            #>

            #? Photo can either be a filepath or base64. We'll check and convert so that the format is always base64
            $PhotoIsBase64  =   try {
                                    [Void][System.Convert]::FromBase64String($photo)
                                    $true
                                } catch {
                                    $false
                                }

            if(-not $PhotoIsBase64){
                if(Test-Path $Photo){
                    # As per https://docs.servicenow.com/en-US/bundle/utah-platform-administration/page/administer/field-administration/task/t_UsingImageFields.html
                    # The image type must be .gif, .jpg/.jpeg, or .png.
                    if([System.IO.Path]::GetExtension($Photo) -in @('.jpg','.jpeg','.gif','.png')){
                        $photo = Convert-ImageFileToBase64 -FilePath $photo    
                    }else{
                        Write-Error "Photo must be one of the following filetypes: .jpg/.jpeg/.gif/.png"
                    }
                }else{
                        Throw "Photo must be either a filepath or a base64 encoded string."
                }
            }            

            #? Photo requires a separate rest call, so we'll remove it from the bound parameters
            [void]$PSBoundParameters.Remove('photo')
        }
    }
    Process {          
        $Response = Invoke-SNOWTableCREATE -table $table -Parameters $PSBoundParameters -Passthru

        if($Response.sys_id -and $photo){
            New-SNOWUserPhoto -Base64String $photo -SysID $Response.sys_id
        }elseif($PSBoundParameters.AsBatchRequest.IsPresent -and $photo){
            Write-Warning "Ignoring 'photo' param. New-SNOWUser does not support the photo parameter while batching.`nPlease make a separate batch call with New-SNOWUserPhoto.`nSee: https://github.com/insomniacc/PSServiceNow/blob/main/docs/Batching_New_User_Photos.MD"
        }

        if($PSBoundParameters.Passthru.IsPresent -or $PSBoundParameters.AsBatchRequest.IsPresent){
            $Response
        }
    }
}