function Get-SNOWUser {
    <#
    .SYNOPSIS
        Retrieves a servicenow user record
    .DESCRIPTION
        Gets a record from the sys_user table
    .NOTES
        Uses Get-SNOWObject as a template function.
    .INPUTS
        String. Any servicenow object with a sys_id property.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://docs.servicenow.com/bundle/sandiego-application-development/page/integrate/inbound-rest/concept/c_TableAPI.html
    .EXAMPLE
        Get-SNOWUser -limit 1 -verbose
        Returns a single user from the sys_user table
    .EXAMPLE
        Get-SNOWUser -user_name 'bruce.wayne' -active $true
        Returns any active user records with the username bruce.wayne
    .EXAMPLE
        Get-SNOWUser -query 'first_name=bruce^last_name=wayne^active=true'
        Returns any active user records with the name bruce wayne
    #>   

    [CmdletBinding()]
    param (
        [Parameter()]
        [alias('FirstName')]
        [string]
        $first_name,
        [Parameter()]
        [alias('LastName')]
        [string]
        $last_name,
        [Parameter()]
        [alias('Username')]
        [string]
        $user_name,
        [Parameter()]
        [alias('EmployeeNumber')]
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
        $company,
        [Parameter()]
        [string]
        $department,
        [Parameter()]
        [string]
        $manager,
        [Parameter()]
        [boolean]
        $locked_out
    )
    DynamicParam { Import-DefaultParams -TemplateFunction "Get-SNOWObject" }

    Begin {
        $table = "sys_user"
    }
    Process {
        Invoke-SNOWTableREAD -table $table -Parameters $PSBoundParameters
    }
}