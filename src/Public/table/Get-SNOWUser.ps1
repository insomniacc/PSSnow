function Get-SNOWUser {
    [CmdletBinding()]
    param (
        [Parameter()]
        [alias('firstname')]
        [string]
        $first_name,
        [Parameter()]
        [alias('lastname')]
        [string]
        $last_name,
        [Parameter()]
        [alias('username')]
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