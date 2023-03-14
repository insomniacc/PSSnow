function Get-SNOWRITMVariables {
    [CmdletBinding()]
    [alias('Get-SNOWSCRequestedItemVariables')]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName='number')]
        [string]
        $number,
        [Parameter(Mandatory, ParameterSetName='sysid')]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [alias('sysid')]
        [string]
        $sys_id
    )
    begin {
        Assert-SNOWAuth
    }
    process {
        if($number){
            $operator = "LIKE"
            $RITMID = $number
        }else{
            $operator = "="
            $RITMID = $sys_id
        }
        
        $MTOMSplat = @{
            Table  = "sc_item_option_mtom"
            Query  = "request_item$operator$RITMID"
            Fields =    @( 
                            "sc_item_option.item_option_new.name",
                            "sc_item_option.item_option_new",
                            "sc_item_option.value"
                        ) 
            ExcludeReferenceLinks = $true
            DisplayValue          = $true
        }
        $RITMVariables = Get-SNOWObject @MTOMSplat 

        if($RITMVariables){
            $SelectAliases = @(
                @{N='label';E={$_."sc_item_option.item_option_new"}},
                @{N='name';E={$_."sc_item_option.item_option_new.name"}},
                @{N='value';E={$_."sc_item_option.value"}}
            )
            $RITMVariables = $RITMVariables | Select-Object $SelectAliases
            return $RITMVariables
        }
    }
}