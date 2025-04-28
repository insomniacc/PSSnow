---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/New-SNOWAuthWebSession.md
schema: 2.0.0
---

# New-SNOWAuthWebSession

## SYNOPSIS
Creates an authenticated web session to ServiceNow using credentials from SNOWAuth.

## SYNTAX

```
New-SNOWAuthWebSession
```

## DESCRIPTION
This function creates an authenticated web session using two possible methods:

Method 1 - Via get_publish_info endpoint:
1.
Makes a GET request to /sn_devstudio_/v1/get_publish_info endpoint using a WebSession
2.
Extracts the cK token from the response JSON under 'ck' property
3.
Extract the JSESSIONID and glide_* cookies from the response

Method 2 - Via form login:
1.
Performs initial GET request to /login.do to obtain session cookies and initial security token (in hidden input field)
2.
Submits POST request to /login.do with credentials in form data
3.
Extracts cK token by searching for 'g_ck = ' pattern in the response JavaScript
4.
The token is typically found between quotes after 'g_ck = ' declaration

This function requires that Set-SNOWAuth has been run first to set credentials.

## EXAMPLES

### EXAMPLE 1
```powershell
New-SNOWAuthWebSession
```

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES
Both methods achieve the same result of obtaining a valid cK token:
- Method 1 (get_publish_info) is faster but requires existing authentication
- Method 2 (form login) works without prior authentication but requires multiple requests
- The cK token is used along with cookies to authenticate subsequent requests
- This function uses credentials stored in $Script:SNOWAuth

## RELATED LINKS

