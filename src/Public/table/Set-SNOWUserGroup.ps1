function Set-SNOWUserGroup {
    <#
    .SYNOPSIS
        Updates a sys_user_group record in SNOW
    .DESCRIPTION
        Updates a record from the sys_user_group table
    .NOTES
        Uses Set-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s (-PassThru only).
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWUserGroup.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        Set-SNOWUserGroup -Sys_ID "<sys_id>" -Properties @{"<key>"="<value>"} -verbose
        Updates a specific record in the table sys_user_group
    #>  
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "")]
    [CmdletBinding(SupportsShouldProcess)]
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
    DynamicParam { Import-DefaultParamSet -TemplateFunction "Set-SNOWObject" }

    Begin {
        $table = "sys_user_group"
    }
    Process {
        Invoke-SNOWTableUPDATE -table $table -Parameters $PSBoundParameters
    }
}

