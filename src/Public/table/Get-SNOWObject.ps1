function Get-SNOWObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Table,
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateScript({
            if($_ -match "^[0-9a-f]{32}$"){
                $true
            }else{
                Throw "Must be a valid sys_id"
            }
        })]
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
        [ValidateRange(0, [int]::MaxValue)]
        [int]
        $Offset,
        [Parameter()]
        [ValidateRange(0, [int]::MaxValue)]
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

    Process {
        Invoke-SNOWTableREAD -table $Table -Parameters $PSBoundParameters
    }
}