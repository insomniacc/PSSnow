function Set-SNOWUser {
    [CmdletBinding(SupportsShouldProcess)]
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
    DynamicParam { Import-DefaultParams -TemplateFunction "Set-SNOWObject" }

    Begin {
        $table = "sys_user"
    }
    Process {
        Invoke-SNOWTableUPDATE -table $table -Parameters $PSBoundParameters
    }
}