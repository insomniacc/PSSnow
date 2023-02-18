function New-SNOWObject {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Table,
        [Parameter()]
        [hashtable]
        $Properties,
        [Parameter()]
        [switch]
        $PassThru,
        [Parameter()]
        [switch]
        $AsBatchRequest
     )

    Process {
        Invoke-SNOWTableCREATE -table $Table -Parameters $PSBoundParameters
    }
}