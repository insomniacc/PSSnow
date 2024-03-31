---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/New-SNOWSCCartItem.md
schema: 2.0.0
---

# New-SNOWSCCartItem

## SYNOPSIS
Adds the specified item to the cart of the current user

## SYNTAX

```
New-SNOWSCCartItem [-Sys_ID] <String> [[-Properties] <Hashtable>] [[-Quantity] <Int32>]
 [[-RequestedFor] <String>] [[-AlsoRequestFor] <Array>] [-Checkout] [-PassThru]
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds an item to the service catalog cart.
Checkout can also be initiated using -checkout.

## EXAMPLES

### EXAMPLE 1
```powershell
#todo
```

## PARAMETERS

### -Sys_ID
The sys_id for the catalog item

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Properties
{{ Fill Properties Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Quantity
{{ Fill Quantity Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequestedFor
{{ Fill RequestedFor Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlsoRequestFor
An array of sys_id's to order the item for.
If the associated item does not have the requested_for variable set, the request is rejected.

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Checkout
{{ Fill Checkout Description }}

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

### -PassThru
{{ Fill PassThru Description }}

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
While using this function it is possible to bypass any validation that may be present on the web form.

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWSCCartItem.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWSCCartItem.md)

[https://docs.servicenow.com/csh?topicname=c_ServiceCatalogAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_ServiceCatalogAPI.html&version=latest)


