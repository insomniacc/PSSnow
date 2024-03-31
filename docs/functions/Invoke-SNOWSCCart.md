---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Invoke-SNOWSCCart.md
schema: 2.0.0
---

# Invoke-SNOWSCCart

## SYNOPSIS
Can be used to checkout or empty a cart

## SYNTAX

### checkout (Default)
```
Invoke-SNOWSCCart [-Checkout] [-PassThru] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### empty
```
Invoke-SNOWSCCart [-Sys_id <String>] [-Empty] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
either processes a cart or clears the contents depending on paramters

## EXAMPLES

### EXAMPLE 1
```powershell
New-SNOWSCCartItem -Sys_ID "e91336da4fff0200086eeed18110c7a3" -Properties @{
    primary_contact  = "a8f98bb0eb32010045e1a5115206fe3a"
    cost_center      = "a581ab703710200044e0bfc8bcbe5de8"
    ip_range         = "127.0.0.1"
    business_purpose = "testing"
}
Invoke-SNOWSCCart -Checkout -PassThru
```

### EXAMPLE 2
```powershell
New-SNOWSCCartItem -Sys_ID "e91336da4fff0200086eeed18110c7a3" -Properties @{
    primary_contact  = "a8f98bb0eb32010045e1a5115206fe3a"
    cost_center      = "a581ab703710200044e0bfc8bcbe5de8"
    ip_range         = "127.0.0.1"
    business_purpose = "testing"
}
Invoke-SNOWSCCart -Empty
```

## PARAMETERS

### -Sys_id
{{ Fill Sys_id Description }}

```yaml
Type: System.String
Parameter Sets: empty
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Empty
{{ Fill Empty Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: empty
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Checkout
{{ Fill Checkout Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: checkout
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
{{ Fill PassThru Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: checkout
Aliases:

Required: False
Position: Named
Default value: False
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
If one-step checkout, the method checks out (saves) the cart and returns the request number and the request order ID. 
If two-step checkout, the method returns the cart order status and all the information required for two-step checkout.

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Invoke-SNOWSCCart.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Invoke-SNOWSCCart.md)

[https://docs.servicenow.com/csh?topicname=c_ServiceCatalogAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_ServiceCatalogAPI.html&version=latest)


