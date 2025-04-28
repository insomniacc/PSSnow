function Test-SNOWUpdateSet {
    <#
    .SYNOPSIS
        Tests an update set XML file to determine if it contains an update set.

    .DESCRIPTION
        This function tests an update set XML file to determine if it contains an update set. 
        The function uses XPath to search for the sys_remote_update_set element with an empty parent display_value.

    .PARAMETER Path
        The path to the update set XML file.

    .EXAMPLE
        Test-SNOWUpdateSet -Path "C:\Temp\MyUpdateSet.xml"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Path
    )

    process {
        $Path = Resolve-Path -Path $Path
        $MainUpdateSet = Select-Xml -Path $Path -XPath "/unload/sys_remote_update_set[parent[@display_value='']='']" | 
                        Select-Object -ExpandProperty Node | 
                        Select-Object -First 1
        
        if ($MainUpdateSet) {
            return @{
                name     = $MainUpdateSet.name
                sys_id   = $MainUpdateSet.sys_id
                FullName = $Path
            }
        }
        
        Write-Warning 'No update set found in the file'
        return $null
    }
}
