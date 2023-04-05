function Get-SNOWUserGroup {
    <#
    .SYNOPSIS
        Retrieves a sys_user_group record from SNOW
    .DESCRIPTION
        Gets a record from the sys_user_group table
    .NOTES
        Uses Get-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWUserGroup.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Get-SNOWUserGroup -limit 1 -verbose
        Returns a single record from sys_user_group
    #>   

    [CmdletBinding()]
    param (
        [Parameter()]
        [boolean]
        $active,
        [Parameter()]
        [string]
        $cost_center,
        [Parameter()]
        [string]
        $default_assignee,
        [Parameter()]
        [string]
        $description,
        [Parameter()]
        [alias('group_email')]
        [string]
        $email,
        [Parameter()]
        [boolean]
        $exclude_manager,
        [Parameter()]
        [boolean]
        $include_members,
        [Parameter()]
        [string]
        $manager,
        [Parameter()]
        [string]
        $name,
        [Parameter()]
        [string]
        $parent,
        [Parameter()]
        [string]
        $roles,
        [Parameter()]
        [string]
        $source,
        [Parameter()]
        [string]
        $type
    )
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Get-SNOWObject" }

    Begin {
        $table = "sys_user_group"
    }
    Process {
        Invoke-SNOWTableREAD -table $table -Parameters $PSBoundParameters
    }
}

