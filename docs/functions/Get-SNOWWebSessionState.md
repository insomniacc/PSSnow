---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Get-SNOWWebSessionState.md
schema: 2.0.0
---

# Get-SNOWWebSessionState

## SYNOPSIS
Retrieves the current state of a ServiceNow web session.

## SYNTAX

```
Get-SNOWWebSessionState [-ValidateSession] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
The Get-SNOWWebSessionState function examines and returns detailed information about the current
ServiceNow web session, including token validity, cookie information, and authentication status.

This function helps diagnose authentication issues and verifies that a session is properly 
established before making API calls to ServiceNow.

When validation is requested, it makes a test API call to 
/api/now/v2/table/sys_user to verify the session is active and authenticated.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWWebSessionState
```

Returns basic information about the current web session without making any validation calls.
Shows security token status, cookie validity, and expiration information.

### EXAMPLE 2
```powershell
Get-SNOWWebSessionState -ValidateSession
```

Returns detailed session state information and validates the session by making a test 
API call to verify authentication.
Includes current user information in the output.

## PARAMETERS

### -ValidateSession
When specified, performs a live validation by making a test API call to ServiceNow
to confirm the session is active and authenticated.
This will retrieve the current
user information to verify proper authorization.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

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

## NOTES
This function requires a valid ServiceNow session established via Set-SNOWAuth or 
New-SNOWAuthWebSession before use.

The session state includes details about:
- Security token validity
- Cookie expiration times
- Authentication status
- User information (when validation is performed)

## RELATED LINKS

