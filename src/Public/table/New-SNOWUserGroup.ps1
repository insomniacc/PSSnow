function New-SNOWUserGroup {
    <#
    .SYNOPSIS
        Creates a sys_user_group record in SNOW
    .DESCRIPTION
        Creates a record in the sys_user_group table
    .NOTES
        Uses New-SNOWObject as a template function.
    .OUTPUTS
        PSCustomObject. The full table record/s (-PassThru only).
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWUserGroup.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest
    .EXAMPLE
        New-SNOWUserGroup -Properties @{"<key>"="<value>"} -PassThru
        Creates a single record in sys_user_group and returns the new record with SysID
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
    DynamicParam { Import-DefaultParamSet -TemplateFunction "New-SNOWObject" }

    Begin {
        $table = "sys_user_group"
    }
    Process {
        Invoke-SNOWTableCREATE -table $table -Parameters $PSBoundParameters
    }
}

