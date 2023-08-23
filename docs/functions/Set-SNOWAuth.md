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
 [-ProxyCredential <PSCredential>] [-HandleRatelimiting] [-WebCallTimeoutSeconds <Int32>] [<CommonParameters>]
```

### OAuth
```
Set-SNOWAuth -Instance <String> -Credential <PSCredential> -ClientID <String> -ClientSecret <SecureString>
 [-ProxyURI <String>] [-ProxyCredential <PSCredential>] [-HandleRatelimiting] [-WebCallTimeoutSeconds <Int32>]
 [<CommonParameters>]
```

### GetSNOWAuth
```
Set-SNOWAuth -AuthObject <Object> [<CommonParameters>]
```

## DESCRIPTION
Applies module scope authentication for PSSnow

## EXAMPLES

### EXAMPLE 1
```powershell
Set-SNOWAuth -Instance "InstanceName" -Credential (get-credential) -Verbose
Applies basic authentication in the current session for instance 'InstanceName.service-now.com'
```

## PARAMETERS

### -Instance
Instance name e.g dev123456

```yaml
Type: System.String
Parameter Sets: Basic, OAuth
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
Parameter Sets: OAuth
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
Parameter Sets: Basic, OAuth
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
Parameter Sets: Basic, OAuth
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
Parameter Sets: Basic, OAuth
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
Parameter Sets: Basic, OAuth
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AuthObject
{{ Fill AuthObject Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWAuth.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWAuth.md)

[https://docs.servicenow.com/csh?topicname=c_RESTAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_RESTAPI.html&version=latest)


