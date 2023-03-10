function Confirm-SysID {
    param(
        [Parameter(Mandatory)]
        [alias('SysID')]
        [string]
        $sys_id,
        [switch]
        $ValidateScript
    )

    $IsSysID = $sys_id -match "^[0-9a-f]{32}$"

    if($ValidateScript.IsPresent -and -not $IsSysID){
        Throw "A valid sys_id was not provided"
    }else{
        $IsSysID
    }
}