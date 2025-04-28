---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Get-SNOWWebConcourseState.md
schema: 2.0.0
---

# Get-SNOWWebConcourseState

## SYNOPSIS
Retrieves the current state of the active ServiceNow session.

## SYNTAX

```
Get-SNOWWebConcourseState [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function interacts with the ServiceNow API or session context to obtain the current state of the active session. 
It can be used to check session details such as authentication status, user information, or other session-specific data.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-ServiceNowSessionState
This command retrieves and displays the current state of the active ServiceNow session.
```

## PARAMETERS

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: System.Management.Automation.ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

Returns a PSCustomObject with the structure below:
### {
###   "Current": {
###     "currentUpdateSet": "@{name=Test Import Set Old [Global]; sysId=5c40a8bf83bc2a10f2dbcac6feaad318}",
###     "currentDomain": "@{used=False; label=global; image=; reference=False; rawLabel=global; selected=False; missing=False; value=global}",
###     "currentApplication": "@{name=Global; scopeName=global; sysId=global}"
###   },
###   "ConcourseList": {
###     "availableUpdateSets": [...],
###     "availableDomains": [..],
###     "availableApplications": [..],                                                                                                                                                                                                                   ",
###     "domainTable": "sys_user_group"
###   }
### }
## NOTES
Ensure that the ServiceNow session is active and properly authenticated before calling this function.

## RELATED LINKS

