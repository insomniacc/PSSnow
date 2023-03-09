function Set-SNOWUser {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $first_name,
        $last_name,
        $middle_name,
        $user_name,
        $employee_number,
        $email,
        $active,
        $Company,
        $Department,
        $Manager,
        $locked_out,
        $user_password
    )
    DynamicParam { Import-DefaultParams -TemplateFunction "Set-SNOWObject" }

    Begin {
        $table = "sys_user"
        
        if($PSBoundParameters.ContainsKey('user_password') -and -not $PSBoundParameters.ContainsKey('InputDisplayValue')){
            # This is requird for setting encrypted fields
            $PSBoundParameters.add('InputDisplayValue',$True)
        }
    }
    Process {
        Invoke-SNOWTableUPDATE -table $table -Parameters $PSBoundParameters
    }
}