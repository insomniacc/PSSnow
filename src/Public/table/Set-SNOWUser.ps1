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
        $locked_out,
        $user_password
    )
    DynamicParam { Import-DefaultParams -TemplateFunction "Set-SNOWObject" }

    Begin {
        $table = "sys_user"
        
        if($PSBoundParameters.ContainsKey('user_password') -and -not $PSBoundParameters.ContainsKey('InputDisplayValue')){
            $PSBoundParameters.add('InputDisplayValue',$True)
        }
    }
    Process {
        Invoke-SNOWTableUPDATE -table $table -Parameters $PSBoundParameters
    }
}