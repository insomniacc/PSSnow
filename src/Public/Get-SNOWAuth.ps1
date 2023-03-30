function Get-SNOWAuth {
    <#
    .SYNOPSIS
        Returns the currently set SNOWAuth
    .DESCRIPTION
       Returns the module scope authentication for PSSnow
    .EXAMPLE
        Get-SNOWAuth
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWAuth.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_RESTAPI.html&version=latest
    #>
    param ()

    return $Script:SNOWAuth
}