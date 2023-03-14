function Get-SNOWRITMVariables {
    [CmdletBinding()]
    [alias('Get-SNOWSCRequestedItemVariables')]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName='number')]
        [string]
        $Number,
        [Parameter(Mandatory, ParameterSetName='sysid')]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [alias('sysid')]
        [string]
        $Sys_Id,
        [Parameter()]
        [switch]
        $IncludeLabels
    )
    begin {
        Assert-SNOWAuth
        $table = "sc_item_option_mtom"
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
            Table  = $table
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
            if($IncludeLabels.IsPresent){
                $OutputObject = [PSCustomObject]@{}
                Foreach($RITMVariable in $RITMVariables){
                    $OutputRow = [PSCustomObject]@{
                        label = $RITMVariable."sc_item_option.item_option_new"
                        value = $RITMVariable."sc_item_option.value"
                    }
                    $OutputObject | Add-Member -MemberType NoteProperty -Name $RITMVariable."sc_item_option.item_option_new.name" -Value $OutputRow
                }
            }else{
                $OutputObject = [PSCustomObject]@{}
                Foreach($RITMVariable in $RITMVariables){
                    $OutputObject | Add-Member -MemberType NoteProperty -Name $RITMVariable."sc_item_option.item_option_new.name" -Value $RITMVariable."sc_item_option.value"
                }
            }
    
            return $OutputObject
        }
    }
}