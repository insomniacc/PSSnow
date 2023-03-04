<#todo
        sysparm_display_value
        sysparm_fields
        sysparm_query_no_domain
#>

function Set-SNOWObject {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Table,
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
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
        [hashtable]
        $Properties,
        [Parameter()]
        [switch]
        $InputDisplayValue,
        [Parameter()]
        [switch]
        $PassThru,
        [Parameter(Hidden)]
        [switch]
        $AsBatchRequest
     )

    Process {
        Invoke-SNOWTableUPDATE -table $Table -Parameters $PSBoundParameters
    }
}