---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Invoke-SNOWGlideAjax.md
schema: 2.0.0
---

# Invoke-SNOWGlideAjax

## SYNOPSIS
Sends a GlideAjax request to a ServiceNow instance and returns the response synchronously.

## SYNTAX

```
Invoke-SNOWGlideAjax [-Params] <Hashtable> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function sends a GlideAjax request to a ServiceNow instance using the provided parameters.
It requires a valid WebSession, which can be established using the \`Set-SNOWAuth\` function with the \`-UseWebSession\` switch.

## EXAMPLES

### EXAMPLE 1
```powershell
$Params = @{
    'sysparm_processor' = 'global.UpdateSetAjax'
    'sysparm_type'      = 'getUpdateSets'
}
$Response = Invoke-SNOWGlideAjax -Params $Params
```

## PARAMETERS

### -Params
A hashtable containing the parameters for the GlideAjax request. 
The \`sysparm_processor\` key is required.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
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
- Requires a valid WebSession.
- The \`sysparm_processor\` parameter is mandatory.
- Returns a hashtable containing the raw response and parsed attributes.
- Tries to destructure the response XML into a hashtable. The raw response is also returned for custom processing.

## RELATED LINKS

