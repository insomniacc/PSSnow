function Get-SNOWRITMVariableSet {
    <#
    .SYNOPSIS
        Gets all associated variables for a RITM
    .DESCRIPTION
        Returns all the RITM variables and display labels
    .EXAMPLE
        Get-SNOWRITMVariableSet -number "RITM0010001"
        Returns RITM Variables for RITM0010001
    .EXAMPLE
        Get-SNOWRITMVariableSet -Sys_id a07e6bd947616110d3e5fa8bd36d4339
        Returns RITM Variables for the RITM with a sys_id of a07e6bd947616110d3e5fa8bd36d4339
    .EXAMPLE
        Get-SNOWRITMVariableSet -number "RITM0010001" -IncludeLabels
        Returns RITM Variables for RITM0010001, adding the display label to the output object
    .EXAMPLE
        Get-SNOWSCRequestedItem -Number "RITM0010001" | Get-SNOWRITMVariableSet
        Returns RITM Variables for RITM0010001
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWRITMVariableSet.md
    #>

    [CmdletBinding(DefaultParameterSetName='sys_id')]
    [alias('Get-SNOWSCRequestedItemVariableSet')]
    [alias('Get-SNOWSCRequestedItemVariable')]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName='number')]
        [string]
        $Number,
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName='sys_id')]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [alias('sysid')]
        [string]
        $Sys_Id,
        [Parameter(ParameterSetName='sys_id')]
        [Parameter(ParameterSetName='number')]
        [switch]
        $IncludeLabels
    )
    begin {
        $table = "sc_item_option_mtom"
    }
    process {
        switch ($PSCmdlet.ParameterSetName) {
            "number" {
                $RITM = Get-SNOWSCRequestedItem -number $Number -Fields @('sys_id')
                if($null -eq $RITM){ 
                    Write-Error "Unable to locate $Number"
                    return         
                }
                $RitmID = $RITM.sys_id
            }
            "sys_id" {
                $RitmID = $sys_id
            }
        }
        
        $MTOMSplat = @{
            Table  = $table
            Query  = "request_item=$RitmID"
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
            $OutputObject = [PSCustomObject]@{}

            if($IncludeLabels.IsPresent){
                Foreach($RITMVariable in $RITMVariables){
                    $OutputRow = [PSCustomObject]@{
                        label = $RITMVariable."sc_item_option.item_option_new"
                        value = $RITMVariable."sc_item_option.value"
                    }
                    $OutputObject | Add-Member -MemberType NoteProperty -Name $RITMVariable."sc_item_option.item_option_new.name" -Value $OutputRow
                }
            }else{
                Foreach($RITMVariable in $RITMVariables){
                    $OutputObject | Add-Member -MemberType NoteProperty -Name $RITMVariable."sc_item_option.item_option_new.name" -Value $RITMVariable."sc_item_option.value"
                }
            }

            switch ($PSCmdlet.ParameterSetName) {
                "number" {
                    $OutputObject | Add-Member -MemberType NoteProperty -Name "number" -Value $number
                }
                "sys_id" {
                    $OutputObject | Add-Member -MemberType NoteProperty -Name "sys_id" -Value $sys_id
                }
            }
    
            return $OutputObject
        }
    }
}