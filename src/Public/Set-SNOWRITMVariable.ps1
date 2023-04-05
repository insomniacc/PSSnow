function Set-SNOWRITMVariable {
    <#
    .SYNOPSIS
        Set the value of a variable associated with a RITM
    .DESCRIPTION
        Updates the value of a variable in the sc_item_option table
    .EXAMPLE
        Set-SNOWRITMVariable -Sys_id "a07e6bd947616110d3e5fa8bd36d4339" -Name "business_purpose" -Value "Hello World"
        Sets the value of business_purpose on a RITM with the sys_id of 'a07e6bd947616110d3e5fa8bd36d4339' to 'Hello World'
    .EXAMPLE
        Set-SNOWRITMVariable -Number "RITM0010001" -Name "business_purpose" -Value "Hello World"
        Sets the value of business_purpose on RITM00100001 to 'Hello World'
    .EXAMPLE
        Get-SNOWSCRequestedItem -number "RITM00100001" | Set-SNOWRITMVariable -Name "business_purpose" -Value "Hello World"
        Sets the value of business_purpose on RITM00100001 to 'Hello World'
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWRITMVariable.md
    #>

    [CmdletBinding(DefaultParameterSetName='sys_id', SupportsShouldProcess)]
    [alias('Set-SNOWSCRequestedItemVariable')]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName='sys_id')]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [alias('sysid')]
        [string]
        $Sys_Id,
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName='number')]
        [string]
        $Number,
        [Parameter(Mandatory, ParameterSetName='sys_id')]
        [Parameter(Mandatory, ParameterSetName='number')]
        [string]
        $Name,
        [Parameter(Mandatory, ParameterSetName='sys_id')]
        [Parameter(Mandatory, ParameterSetName='number')]
        [string]
        $Value
    )
    begin {}
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

        #? Get the MTOM Pointer
        $MTOMRecord = Get-SNOWObject -Table "sc_item_option_mtom" -Query "request_item=$RitmID^sc_item_option.item_option_new.name=$Name" -Fields @( "sc_item_option.item_option_new.name", "sc_item_option", "sc_item_option.value") -ExcludeReferenceLinks
        if($null -eq $MTOMRecord){
            Write-Error "Unable to locate variable '$Name'"
            return 
        }

        #? Update the variable's value in the sc_item_option table
        if($PSCmdlet.ShouldProcess("RITM: $RitmID \ Variable: $Name","UPDATE")){
            Set-SNOWObject -table "sc_item_option" -sys_id $MTOMRecord.sc_item_option -Properties @{value=$Value}
        }
    }
}