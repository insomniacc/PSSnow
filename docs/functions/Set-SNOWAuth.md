---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Set-SNOWAuth.md
schema: 2.0.0
---

# Set-SNOWAuth

## SYNOPSIS
Sets ServiceNow authentication in the current session.

## SYNTAX

### Basic (Default)
```
Set-SNOWAuth -Instance <String> -Credential <PSCredential> [-ProxyURI <String>]
 [-ProxyCredential <PSCredential>] [-HandleRatelimiting] [-WebCallTimeoutSeconds <Int32>] [-BypassDefaultProxy]
 [-UseWebSession] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### OAuthToken
```
Set-SNOWAuth -Instance <String> -ClientID <String> [-ClientSecret <SecureString>] [-ProxyURI <String>]
 [-ProxyCredential <PSCredential>] [-HandleRatelimiting] [-WebCallTimeoutSeconds <Int32>] [-BypassDefaultProxy]
 [-UseWebSession] -AccessToken <String> -RefreshToken <String> [-ExpiresInSeconds <Int32>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### OAuth
```
Set-SNOWAuth -Instance <String> -Credential <PSCredential> -ClientID <String> -ClientSecret <SecureString>
 [-ProxyURI <String>] [-ProxyCredential <PSCredential>] [-HandleRatelimiting] [-WebCallTimeoutSeconds <Int32>]
 [-BypassDefaultProxy] [-UseWebSession] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### GetSNOWAuth
```
Set-SNOWAuth -AuthObject <Object> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Applies module scope authentication for PSSnow

## EXAMPLES

### EXAMPLE 1
```powershell
Set-SNOWAuth -Instance "InstanceName" -Credential (get-credential) -Verbose
# Applies basic authentication in the current session for instance 'InstanceName.service-now.com'
```

### EXAMPLE 2
```powershell
Set-SNOWAuth -Instance "InstanceName" -ClientID "ClientID" -ClientSecret (ConvertTo-SecureString -String "ClientSecret" -AsPlainText -Force) -Credential (get-credential) -Verbose
# Applies OAuth authentication in the current session for instance 'InstanceName.service-now.com'
```

### EXAMPLE 3
```powershell
Set-SNOWAuth -Instance "InstanceName" -ClientID "ClientID" -AccessToken "AccessToken" -RefreshToken "RefreshToken" -ExpiresInSeconds 3600 -Verbose
# Applies OAuth authentication with a Public Client in the current session for instance 'InstanceName.service-now.com' using provided tokens.
```

### EXAMPLE 4
```powershell
Set-SNOWAuth -Instance "InstanceName" -ClientID "ClientID" -AccessToken "AccessToken" -RefreshToken "RefreshToken" -ExpiresInSeconds 3600 -ClientSecret (ConvertTo-SecureString -String "ClientSecret" -AsPlainText -Force) -Verbose
# Applies OAuth authentication with a Private Client in the current session for instance 'InstanceName.service-now.com' using provided tokens.
```

## PARAMETERS

### -Instance
Instance name e.g dev123456

```yaml
Type: System.String
Parameter Sets: Basic, OAuthToken, OAuth
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Basic Auth

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: Basic, OAuth
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientID
OAuth ClientID

```yaml
Type: System.String
Parameter Sets: OAuthToken, OAuth
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientSecret
OAuth ClientSecret

```yaml
Type: System.Security.SecureString
Parameter Sets: OAuthToken
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: System.Security.SecureString
Parameter Sets: OAuth
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyURI
By default if this param is not used the system default proxy will be provided if configured.
URI should include the port if used.

```yaml
Type: System.String
Parameter Sets: Basic, OAuthToken, OAuth
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProxyCredential
Provide credentials if you do not want to use default auth for any existing proxy

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: Basic, OAuthToken, OAuth
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HandleRatelimiting
Servicenow rate limit policies are per hour, this will cause commands to sleep and wait until those rate limits are refreshed, instead of returning an error.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Basic, OAuthToken, OAuth
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WebCallTimeoutSeconds
Default is no specified timeout

```yaml
Type: System.Int32
Parameter Sets: Basic, OAuthToken, OAuth
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthObject
Use this parameter to pass an existing SNOWAuth context object to the function

```yaml
Type: System.Object
Parameter Sets: GetSNOWAuth
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -BypassDefaultProxy
Only supported on PS Core.
5.1 users will need to add a bypass via device config.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Basic, OAuthToken, OAuth
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseWebSession
Create a web session for the session context.
This will store the cookies and X-UserToken in the session object.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Basic, OAuthToken, OAuth
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccessToken
An e

```yaml
Type: System.String
Parameter Sets: OAuthToken
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RefreshToken
OAuth Refresh Token

```yaml
Type: System.String
Parameter Sets: OAuthToken
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpiresInSeconds
Token expiration time in seconds

```yaml
Type: System.Int32
Parameter Sets: OAuthToken
Aliases:

Required: False
Position: Named
Default value: 1800
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

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/next/docs/UserGuide.MD#authentication](https://github.com/insomniacc/PSSnow/blob/next/docs/UserGuide.MD#authentication)

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWAuth.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWAuth.md)

[https://docs.servicenow.com/csh?topicname=c_RESTAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_RESTAPI.html&version=latest)


