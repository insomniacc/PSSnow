function Remove-SNOWObject {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param (      
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateScript({
            if($_ -match "^[0-9a-f]{32}$"){
                $true
            }else{
                Throw "Must be a valid sys_id"
            }
        })]
        [string]
        $Sys_ID,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Table
    )

    Process {
        Invoke-SNOWTableDELETE -table $Table -Parameters $PSBoundParameters
    }
}