---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/Get-SNOWSCItem.md
schema: 2.0.0
---

# Get-SNOWSCItem

## SYNOPSIS
Retrieves a sc_cat_item record from SNOW

## SYNTAX

```
Get-SNOWSCItem [[-access_type] <String>] [[-active] <Boolean>] [[-availability] <String>]
 [[-billable] <Boolean>] [[-category] <String>] [[-checked_out] <String>] [[-cost] <String>]
 [[-custom_cart] <String>] [[-delivery_plan] <String>] [[-delivery_plan_script] <String>]
 [[-delivery_time] <String>] [[-description] <String>] [[-display_price_property] <String>]
 [[-entitlement_script] <String>] [[-flow_designer_flow] <String>] [[-fulfillment_automation_level] <String>]
 [[-group] <String>] [[-hide_sp] <Boolean>] [[-icon] <String>] [[-ignore_price] <Boolean>] [[-image] <String>]
 [[-list_price] <String>] [[-location] <String>] [[-mandatory_attachment] <Boolean>] [[-meta] <String>]
 [[-mobile_hide_price] <Boolean>] [[-mobile_picture] <String>] [[-mobile_picture_type] <String>]
 [[-model] <String>] [[-name] <String>] [[-no_attachment_v2] <Boolean>] [[-no_cart] <Boolean>]
 [[-no_cart_v2] <Boolean>] [[-no_delivery_time_v2] <Boolean>] [[-no_order] <Boolean>]
 [[-no_order_now] <Boolean>] [[-no_proceed_checkout] <Boolean>] [[-no_quantity] <Boolean>]
 [[-no_quantity_v2] <Boolean>] [[-no_search] <Boolean>] [[-no_wishlist_v2] <Boolean>] [[-omit_price] <Boolean>]
 [[-order] <String>] [[-ordered_item_link] <String>] [[-owner] <String>] [[-picture] <String>]
 [[-preview] <String>] [[-price] <String>] [[-published_ref] <String>] [[-recurring_frequency] <String>]
 [[-recurring_price] <String>] [[-request_method] <String>] [[-roles] <String>] [[-sc_catalogs] <String>]
 [[-sc_ic_item_staging] <String>] [[-sc_ic_version] <String>] [[-sc_template] <String>]
 [[-short_description] <String>] [[-show_variable_help_on_load] <Boolean>] [[-start_closed] <Boolean>]
 [[-state] <String>] [[-taxonomy_topic] <String>] [[-template] <String>] [[-template_manager_roles] <String>]
 [[-type] <String>] [[-use_sc_layout] <Boolean>] [[-vendor] <String>] [[-visible_bundle] <Boolean>]
 [[-visible_guide] <Boolean>] [[-visible_standalone] <Boolean>] [[-workflow] <String>]
 [-ProgressAction <ActionPreference>] [-Sys_ID <String>] [-Query <String>] [-Fields <Array>]
 [-DisplayValue <String>] [-ExcludeReferenceLinks] [-Offset <Int32>] [-Limit <Int32>] [-RestrictDomain]
 [-SysParmView <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets a record from the sc_cat_item table

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SNOWSCItem -limit 1 -verbose
Returns a single record from sc_cat_item
```

## PARAMETERS

### -access_type
{{ Fill access_type Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -active
{{ Fill active Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -availability
{{ Fill availability Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billable
{{ Fill billable Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -category
{{ Fill category Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -checked_out
{{ Fill checked_out Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cost
{{ Fill cost Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -custom_cart
{{ Fill custom_cart Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: cart

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -delivery_plan
{{ Fill delivery_plan Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: execution_plan

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -delivery_plan_script
{{ Fill delivery_plan_script Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -delivery_time
{{ Fill delivery_time Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
{{ Fill description Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -display_price_property
{{ Fill display_price_property Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -entitlement_script
{{ Fill entitlement_script Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -flow_designer_flow
{{ Fill flow_designer_flow Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: flow

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -fulfillment_automation_level
{{ Fill fulfillment_automation_level Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -group
{{ Fill group Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: fulfillment_group

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hide_sp
{{ Fill hide_sp Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: hide_on_service_portal

Required: False
Position: 18
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -icon
{{ Fill icon Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ignore_price
{{ Fill ignore_price Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -image
{{ Fill image Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -list_price
{{ Fill list_price Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -location
{{ Fill location Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mandatory_attachment
{{ Fill mandatory_attachment Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -meta
{{ Fill meta Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobile_hide_price
{{ Fill mobile_hide_price Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: hide_price__mobile_listings_

Required: False
Position: 26
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobile_picture
{{ Fill mobile_picture Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: classic_mobile_picture

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobile_picture_type
{{ Fill mobile_picture_type Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: classic_mobile_picture_type

Required: False
Position: 28
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -model
{{ Fill model Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
{{ Fill name Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -no_attachment_v2
{{ Fill no_attachment_v2 Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: hide_attachment

Required: False
Position: 31
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -no_cart
{{ Fill no_cart Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -no_cart_v2
{{ Fill no_cart_v2 Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: hide__add_to_cart_

Required: False
Position: 33
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -no_delivery_time_v2
{{ Fill no_delivery_time_v2 Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: hide_delivery_time

Required: False
Position: 34
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -no_order
{{ Fill no_order Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -no_order_now
{{ Fill no_order_now Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -no_proceed_checkout
{{ Fill no_proceed_checkout Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -no_quantity
{{ Fill no_quantity Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -no_quantity_v2
{{ Fill no_quantity_v2 Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: hide_quantity

Required: False
Position: 39
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -no_search
{{ Fill no_search Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -no_wishlist_v2
{{ Fill no_wishlist_v2 Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: hide__add_to_wish_list_

Required: False
Position: 41
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -omit_price
{{ Fill omit_price Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: omit_price_in_cart

Required: False
Position: 42
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -order
{{ Fill order Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 43
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ordered_item_link
{{ Fill ordered_item_link Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 44
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -owner
{{ Fill owner Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 45
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -picture
{{ Fill picture Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -preview
{{ Fill preview Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: preview_link

Required: False
Position: 47
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -price
{{ Fill price Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -published_ref
{{ Fill published_ref Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: published_item

Required: False
Position: 49
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recurring_frequency
{{ Fill recurring_frequency Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: recurring_price_frequency

Required: False
Position: 50
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recurring_price
{{ Fill recurring_price Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -request_method
{{ Fill request_method Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -roles
{{ Fill roles Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sc_catalogs
{{ Fill sc_catalogs Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: catalogs

Required: False
Position: 54
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sc_ic_item_staging
{{ Fill sc_ic_item_staging Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: created_from_item_design

Required: False
Position: 55
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sc_ic_version
{{ Fill sc_ic_version Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: published_version

Required: False
Position: 56
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sc_template
{{ Fill sc_template Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: associated_template

Required: False
Position: 57
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -short_description
{{ Fill short_description Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -show_variable_help_on_load
{{ Fill show_variable_help_on_load Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: expand_help_for_all_questions

Required: False
Position: 59
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -start_closed
{{ Fill start_closed Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -state
{{ Fill state Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 61
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -taxonomy_topic
{{ Fill taxonomy_topic Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 62
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -template
{{ Fill template Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 63
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -template_manager_roles
{{ Fill template_manager_roles Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 64
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
{{ Fill type Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 65
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -use_sc_layout
{{ Fill use_sc_layout Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: use_cart_layout

Required: False
Position: 66
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -vendor
{{ Fill vendor Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 67
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -visible_bundle
{{ Fill visible_bundle Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: visible_on_bundles

Required: False
Position: 68
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -visible_guide
{{ Fill visible_guide Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: visible_on_guides

Required: False
Position: 69
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -visible_standalone
{{ Fill visible_standalone Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases: visible_elsewhere

Required: False
Position: 70
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -workflow
{{ Fill workflow Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 71
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayValue
{{ Fill DisplayValue Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExcludeReferenceLinks
{{ Fill ExcludeReferenceLinks Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Fields
{{ Fill Fields Description }}

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit
{{ Fill Limit Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Offset
{{ Fill Offset Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

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

### -Query
{{ Fill Query Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestrictDomain
{{ Fill RestrictDomain Description }}

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sys_ID
{{ Fill Sys_ID Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: SysID

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SysParmView
{{ Fill SysParmView Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

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

PSCustomObject. The full table record/s.
## NOTES
Uses Get-SNOWObject as a template function.

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWSCItem.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWSCItem.md)

[https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_TableAPI.html&version=latest)


