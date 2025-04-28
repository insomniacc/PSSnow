
<#
.SYNOPSIS
Retrieves the current state of the active ServiceNow session.

.DESCRIPTION
This function interacts with the ServiceNow API or session context to obtain the current state of the active session. 
It can be used to check session details such as authentication status, user information, or other session-specific data.

.PARAMETER None
This function does not require any parameters.

.OUTPUTS
Returns a PSCustomObject with the structure below:
{
  "Current": {
    "currentUpdateSet": "@{name=Test Import Set Old [Global]; sysId=5c40a8bf83bc2a10f2dbcac6feaad318}",
    "currentDomain": "@{used=False; label=global; image=; reference=False; rawLabel=global; selected=False; missing=False; value=global}",
    "currentApplication": "@{name=Global; scopeName=global; sysId=global}"
  },
  "ConcourseList": {
    "availableUpdateSets": [...],
    "availableDomains": [..],
    "availableApplications": [..],                                                                                                                                                                                                                   ",
    "domainTable": "sys_user_group"
  }
}

.EXAMPLE
PS> Get-ServiceNowSessionState
This command retrieves and displays the current state of the active ServiceNow session.

.NOTES
Ensure that the ServiceNow session is active and properly authenticated before calling this function.
#>
function Get-SNOWWebConcourseState {
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    Param()
    [ordered]@{
        Current       = (Invoke-SNOWWebRequest -Uri 'api/now/ui/concoursepicker/current' -Method 'GET' -UseRestMethod).result
        ConcourseList = (Invoke-SNOWWebRequest -Uri 'api/now/ui/concoursepicker/concourselist' -Method 'GET' -UseRestMethod).result
    }
}