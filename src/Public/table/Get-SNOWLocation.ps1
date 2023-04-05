function Get-SNOWLocation {
    <#
    .SYNOPSIS
        Retrieves a cmn_location record from SNOW
    .DESCRIPTION
        Gets a record from the cmn_location table
    .NOTES
        Uses Get-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWLocation.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Get-SNOWLocation -limit 1 -verbose
        Returns a single record from cmn_location
    #>   

    [CmdletBinding()]
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
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Get-SNOWObject" }

    Begin {
        $table = "cmn_location"
    }
    Process {
        Invoke-SNOWTableREAD -table $table -Parameters $PSBoundParameters
    }
}

