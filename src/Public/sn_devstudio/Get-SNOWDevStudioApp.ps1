function Get-SNOWDevStudioApp {
    <#
    .SYNOPSIS
        Get all VCS apps from api/sn_devstudio/v1/vcs/apps

    .DESCRIPTION
        This function retrieves VCS-enabled applications from ServiceNow DevStudio.
        It calls the ServiceNow API endpoint: api/sn_devstudio/v1/vcs/apps

    .EXAMPLE
        Get-SNOWDevStudioApp
        Returns all VCS-enabled applications in the ServiceNow instance.

    .EXAMPLE
        $apps = Get-SNOWDevStudioApp
        $apps | Select-Object name, id, version
        Retrieves VCS apps and displays selected properties.

    .NOTES
        Requires an active ServiceNow connection configured with Set-SNOWAuth.
    #>
    [CmdletBinding()]
    param ()

    process {
        $Request = @{
            Uri           = 'api/sn_devstudio/v1/vcs/apps'
            Method        = 'GET'
            UseRestMethod = $true
        }
        (Invoke-SNOWWebRequest @Request).result
    }
}
