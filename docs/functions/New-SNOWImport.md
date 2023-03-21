---
external help file: PSSnow-help.xml
Module Name: PSSnow
online version: docs/functions/New-SNOWImport.md
schema: 2.0.0
---

# New-SNOWImport

## SYNOPSIS
Sends a new record to the import API

## SYNTAX

```
New-SNOWImport [-Table] <String> [-Properties] <Hashtable> [-PassThru] [-AsBatchRequest] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The import API can be used to push data into staging tables with transform maps

## EXAMPLES

### EXAMPLE 1
```powershell
$Movies = import-csv -Path "C:\temp\movies.csv"
$Imports = ForEach($Movie in $Movies){
    $MovieProperties = @{
        u_title = $Movie."Movie Title"
        u_director = $Movie.Director
        u_actor = $Movie."Lead Actor"
        u_genre = $Movie.Genre
    }
    New-SNOWImport -table "u_moviesimport" -properties $MovieProperties
}
$Imports.result | Group-Object status | Select Count,Name
```

## PARAMETERS

### -Table
{{ Fill Table Description }}

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

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
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

### -AsBatchRequest
{{ Fill AsBatchRequest Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWImport.md](https://github.com/insomniacc/PSSnow/blob/main/docs/functions/New-SNOWImport.md)

[https://docs.servicenow.com/csh?topicname=c_ImportSetAPI.html&version=latest](https://docs.servicenow.com/csh?topicname=c_ImportSetAPI.html&version=latest)


