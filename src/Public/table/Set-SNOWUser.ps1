function Set-SNOWUser {
    <#
    .SYNOPSIS
        Updates a new servicenow user record
    .DESCRIPTION
        Updates a record in the sys_user table
    .OUTPUTS
        PSCustomObject. The full table record (requires -PassThru).
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWUser.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Get-SNOWUser -user_name 'Bruce.Wayne' -active $true | Set-SNOWUser -middle_name "Thomas"
        Updates the middle_name of the user record bruce.wayne in the sys_user table
    .EXAMPLE
        Set-SNOWUser -middle_name "Thomas" -sys_id 02826bf03710200044e0bfc8bcbe5d3f
        Updates the middle_name of the user record bruce.wayne in the sys_user table
    #> 
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '')]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [string]
        $first_name,
        [Parameter()]
        [string]
        $last_name,
        [Parameter()]
        [string]
        $middle_name,
        [Parameter()]
        [string]
        $user_name,
        [Parameter()]
        [string]
        $employee_number,
        [Parameter()]
        [string]
        $email,
        [Parameter()]
        [boolean]
        $active,
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
        $locked_out,
        [Parameter()]
        [string]
        $user_password
    )
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Set-SNOWObject" }

    Begin {
        $table = "sys_user"
        
        if($PSBoundParameters.ContainsKey('user_password') -and -not $PSBoundParameters.ContainsKey('InputDisplayValue')){
            # This is required for setting encrypted fields
            $PSBoundParameters.add('InputDisplayValue',$True)
        }
    }
    Process {
        Invoke-SNOWTableUPDATE -table $table -Parameters $PSBoundParameters
    }
}