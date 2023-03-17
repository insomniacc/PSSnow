function Get-SNOWRITMVariable {
    <#
    .SYNOPSIS
        Gets all associated variables for a RITM
    .DESCRIPTION
        Returns all the RITM variables and display labels
    .EXAMPLE
        Get-SNOWRITMVariable -number "RITM0010001"
        Returns RITM Variables for RITM0010001
    .EXAMPLE
        Get-SNOWRITMVariable -number "RITM0010001" -IncludeLabels
        Returns RITM Variables for RITM0010001, adding the display label to the output object
    .EXAMPLE
        Get-SNOWSCRequestedItem -Number "RITM0010001" | Get-SNOWRITMVariable
        Returns RITM Variables for RITM0010001
    .LINK
        https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Get-SNOWRITMVariable.md
    #>

    [CmdletBinding()]
    [alias('Get-SNOWSCRequestedItemVariable')]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName='number')]
        [string]
        $Number,
        [Parameter(Mandatory, ParameterSetName='sys_id')]
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
        switch ($PSCmdlet.ParameterSetName) {
            "number" {
                $operator = "LIKE"
                $RitmID = $number
            }
            "sys_id" {
                $operator = "="
                $RitmID = $sys_id
            }
        }
        
        $MTOMSplat = @{
            Table  = $table
            Query  = "request_item$operator$RitmID"
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