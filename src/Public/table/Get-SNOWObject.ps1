function Get-SNOWObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $Table,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        [alias('SysID')]
        $Sys_ID,
        [Parameter()]
        [string]
        $Query,
        [Parameter()]
        [array]
        $Fields,
        [Parameter()]
        [ValidateSet("true","false","all")]
        [string]
        $DisplayValue,
        [Parameter()]
        [switch]
        $ExcludeReferenceLinks,
        [Parameter()]
        [int]
        $Offset,
        [Parameter()]
        [int]
        $Limit,
        [Parameter()]
        [switch]
        $RestrictDomain = $false,
        #[Parameter(DontShow)]
        #[switch]
        #$SuppressPaginationHeader,
        [Parameter(DontShow)]
        [ValidateSet("desktop","mobile","both")]
        [string]
        $SysParmView
    )

    Begin {}
    Process {
        Invoke-SNOWTableGET -table $Table -Parameters $PSBoundParameters
    }
    End {

    }
}