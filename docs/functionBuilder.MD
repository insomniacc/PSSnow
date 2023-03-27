# Function Builder
The function builder was designed to help generate **Table API** functions easily.  
It can be used for those wishing to generate functions for tables that are not listed in the module at present, custom tables, or to recreate existing functions if they are missing modified or custom properties.    
The idea is to input a table name and it will generate the PS function automatically based on a template file in this repo & metadata pulled from ServiceNow.   
The script itself is a bit rough and ready in it's current state ([#29](https://github.com/insomniacc/PSSnow/issues/29)), but it works.  

<details>
<summary>The legacy manual process</summary>

All Table API functions in this module follow the same framework, as such to create a new one the following manual steps would normally be required:
1. Duplicate an existing Table API function of the same verb type. Example: Get-SNOWIncident
2. Rename the file & function name reflective of the new table name
3. Remove all existing parameters and add new parameters that match the relevant table
4. Change the table name in the `Begin{}` block
5. Add the function to the module manifest

While relatively simple, this process still takes time, working out the properties of the target table, the types, mandatory values, display labels/aliases and so on.
</details>

## How-To

### Video Demo
[![Function Builder Demo](https://img.youtube.com/vi/-KzV9Ao9Hsc/0.jpg)](https://www.youtube.com/watch?v=-KzV9Ao9Hsc)
  
### Steps

1. Clone this repo and navigate to `\PSSnow\functionBuilder`
2. `Import-Module "..\src\PSSnow.psd1" -Force`
3. `Set-SNOWAuth` with either credentials or OAuth
4. If you are using a developer instance, ensure its spun up!
5. Run the command shown below these steps  
add `-Force` if you wish to replace an existing function of the same name.   
6. Repeat the above step using the verbs `Set-` and `New-` if required.  
Typically `Remove-` is not used as `Remove-SNOWObject` can be used against any returned record.  
7. Your new functions will generated under the `src\Public\table\` folder and added to the module manifest.
8. Edit the newly generated .ps1 function files, scan through the parameters and validate.  
Remove any parameters that you feel are unnecessary and save.  
Add any additional functionality to the begin or process blocks where required.
9. Run pester tests to ensure everything passes
10. Re-import the module, set authentication and try the new functions
<br><br>
```powershell
.\New-SNOWTableFunction -TableName "sys_user" -FunctionName "Get-SNOWUser" -AddToManifest -Verbose
```

## Notes
### Parameter Length Validation
> ⚠️ If a value is too long and provided to the ServiceNow Table API during New/Set functions it will be automatically cut without warning.

Currently parameter length validation is omitted by default.  
The reasoning is that this likely varies from instance to instance depending on configuration and cannot be easily accounted for out of the box.  
It is therefore available as a switch on the function builder (for individuals generating more customized versions of this module) but not included in the base module functions.  

### Testing
Existing pester tests should cover any newly added TableAPI functions.  
Additional functionality added on top of the function builder generation will need to be accounted for in separate tests.
