function Import-SNOWUpdateSet {
    <#
    .SYNOPSIS
        Imports an update set XML file into ServiceNow using sys_upload.do and a valid WebSession.

    .DESCRIPTION
        This function imports an update set XML file into ServiceNow. It first validates the update set
        and then uploads it to the instance if it doesn't already exist.
        
        This function calls the ServiceNow API endpoint: sys_upload.do
        
        The function requires a valid web session, which can be established using the Connect-SNOW function.
        
    .PARAMETER Path
        The path to the update set XML file.

    .EXAMPLE
        Import-SNOWUpdateSet -Path "C:\Temp\MyUpdateSet.xml"
        
        Validates and imports the specified update set XML file into ServiceNow.
        
    .EXAMPLE
        Get-ChildItem -Path "C:\Temp\UpdateSets\*.xml" | Import-SNOWUpdateSet
        
        Imports all XML files in the specified directory that contain valid update sets.
        
    .EXAMPLE
        Test-SNOWUpdateSet -Path "C:\Temp\MyUpdateSet.xml" | Import-SNOWUpdateSet
        
        Tests if the file contains a valid update set and imports it if valid.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Path
    )

    process {
        # Validate web session
        if (-not (Get-SNOWWebSessionState).Valid) {
            throw "No valid ServiceNow web session established. Please use Connect-SNOW first."
        }
        
        $UpdateSet = Test-SNOWUpdateSet -Path $Path
        
        if (-not $UpdateSet) {
            Write-Error "Update set at ${Path} is not valid" -ErrorAction Stop
            return $null
        }
        
        $ExistingUpdateSet = Get-SNOWUpdateSet -sys_id $UpdateSet.sys_id
        
        if ($ExistingUpdateSet) {
            Write-Information "Update set $($UpdateSet.name) already exists in the instance"
            return $ExistingUpdateSet
        }
        else {
            $attachFile = (Get-Item -Path $UpdateSet.FullName)
            $boundary = "===$([System.Guid]::NewGuid().ToString())"
            $LF = "`n"
            
            # Get the token from the current session
            $sessionState = Get-SNOWWebSessionState
            if (-not $sessionState.SecurityToken) {
                throw "No valid ServiceNow token found. Please use Set-SNOWAuth with -WebSession first."
            }
            
            $bodyLines = (
                "--$boundary",
                "Content-Disposition: form-data; name=`"attachFile`"; filename=`"$($UpdateSet.sys_id).xml`"",
                'Content-Type: text/xml',
                '',
                "$(Get-Content -Path $attachFile -Raw)",
                '',
                "--$boundary",
                'Content-Disposition: form-data; name="sysparm_ck"',
                '',
                "$($sessionState.Token)",
                "--$boundary",
                'Content-Disposition: form-data; name="sysparm_target"',
                '',
                'sys_remote_update_set',
                "--$boundary",
                'Content-Disposition: form-data; name="sysparm_upload_prefix"',
                '',
                '',
                "--$boundary--"
            ) -join $LF
            $Response = Invoke-SNOWWebRequest -URI "sys_upload.do" -Method 'POST' `
                -ContentType "multipart/form-data; boundary=`"$boundary`"" -Body $bodyLines
                
            if ($Response.StatusCode -eq 200) {
                Write-Information "Update set $($UpdateSet.name) imported successfully"
                return Get-SNOWUpdateSet -sys_id $UpdateSet.sys_id
            }
        }
        
        return $null
    }
}
