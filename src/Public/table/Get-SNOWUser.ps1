function Get-SNOWUser {
    [CmdletBinding()]
    param (
        $first_name,
        $last_name,
        $user_name,
        $employee_number,
        $email,
        $active,
        $Company,
        $Department,
        $Manager,
        $locked_out
    )
    DynamicParam { "Get-SNOWObject" | Import-DefaultParams }

    Begin {
        $table = "sys_user"
    }
    Process {
        Invoke-SNOWTableREAD -table $table -Parameters $PSBoundParameters
    }
}