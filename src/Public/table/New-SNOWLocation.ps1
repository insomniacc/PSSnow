function New-SNOWLocation {
    <#
    .SYNOPSIS
        Creates a cmn_location record in SNOW
    .DESCRIPTION
        Creates a record in the cmn_location table
    .NOTES
        Uses New-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s (-PassThru only).
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWLocation.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        New-SNOWLocation -Properties @{"<key>"="<value>"} -PassThru
        Creates a single record in cmn_location and returns the new record with SysID
    #>   
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "")]
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter()]
        [string]
        $city,
        [Parameter()]
        [alias('location_source')]
        [string]
        $cmn_location_source,
        [Parameter()]
        [alias('location_type')]
        [string]
        $cmn_location_type,
        [Parameter()]
        [string]
        $company,
        [Parameter()]
        [string]
        $contact,
        [Parameter()]
        [string]
        $coordinates_retrieved_on,
        [Parameter()]
        [string]
        $country,
        [Parameter()]
        [boolean]
        $duplicate,
        [Parameter()]
        [string]
        $fax_phone,
        [Parameter()]
        [string]
        $full_name,
        [Parameter()]
        [string]
        $latitude,
        [Parameter()]
        [string]
        $lat_long_error,
        [Parameter()]
        [string]
        $life_cycle_stage,
        [Parameter()]
        [string]
        $life_cycle_stage_status,
        [Parameter()]
        [string]
        $longitude,
        [Parameter()]
        [string]
        $managed_by_group,
        [Parameter()]
        [string]
        $name,
        [Parameter()]
        [string]
        $parent,
        [Parameter()]
        [string]
        $phone,
        [Parameter()]
        [string]
        $phone_territory,
        [Parameter()]
        [string]
        $primary_location,
        [Parameter()]
        [alias('state___province')]
        [string]
        $state,
        [Parameter()]
        [boolean]
        $stock_room,
        [Parameter()]
        [string]
        $street,
        [Parameter()]
        [string]
        $time_zone,
        [Parameter()]
        [alias('zip___postal_code')]
        [string]
        $zip
    )
    DynamicParam { Import-DefaultParamSet -TemplateFunction "New-SNOWObject" }

    Begin {
        $table = "cmn_location"
    }
    Process {
        Invoke-SNOWTableCREATE -table $table -Parameters $PSBoundParameters
    }
}

