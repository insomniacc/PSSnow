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

    [CmdletBinding(SupportsShouldProcess)]
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
                Adding photos to a user record is done in a second API call to a different endpoint (attachment API),
                It's been added to this function for ease of use.
                It is not supported by batch API requests in this way, because we need to create the user first to get their sys_id in order to attach the photo.
                In this instance it would be best to make the calls separately by omitting the photo from New-SNOWUser and also running a separate batch with New-SNOWUserPhoto.
                If both -AsBatchRequest and -Photo are provided this will be highlighted in a warning message and the photo will not be set.
            #>         
            #? Photo requires a separate rest call, so we'll remove it from the bound parameters
            [void]$PSBoundParameters.Remove('photo')
        }
    }
    Process {          
        $Response = Invoke-SNOWTableCREATE -table $table -Parameters $PSBoundParameters -Passthru

        if($Response.sys_id -and $photo){
            New-SNOWUserPhoto -SysID $Response.sys_id -filepath $photo
        }elseif($PSBoundParameters.AsBatchRequest.IsPresent -and $photo){
            Write-Warning "Ignoring 'photo' param. New-SNOWUser does not support the photo parameter while batching.`nPlease make a separate batch call with New-SNOWUserPhoto.`nSee: https://github.com/insomniacc/PSServiceNow/blob/main/docs/Batching_New_User_Photos.MD"
        }

        if($PSBoundParameters.Passthru.IsPresent -or $PSBoundParameters.AsBatchRequest.IsPresent){
            $Response
        }
    }
}