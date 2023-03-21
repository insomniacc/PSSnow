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
Set-SNOWAuth -Instance <String> -Credential <PSCredential> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### OAuth
```
Set-SNOWAuth -Instance <String> -Credential <PSCredential> -ClientID <String> -ClientSecret <SecureString>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Applies module scope authentication for PSSnow

## EXAMPLES

### EXAMPLE 1
```powershell
Set-SNOWAuth -Instance "InstanceName" -Credential (get-credential) -Verbose
```

Applies basic authentication in the current session for instance 'InstanceName.service-now.com'

## PARAMETERS

### -Instance
Instance name e.g dev123456

```yaml
Type: System.String
Parameter Sets: (All)
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
Parameter Sets: (All)
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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWAuth.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Set-SNOWAuth.md)

[https://docs.servicenow.com/csh?topicname=c_RESTAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_RESTAPI.html&version=latest)


