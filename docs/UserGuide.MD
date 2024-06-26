# Table of contents
- [Authentication](#authentication)
- [Table API](#table-api)
    - [Get-SNOWObject](#get-snowobject)
    - [Set-SNOWObject](#set-snowobject)
    - [New-SNOWObject](#new-snowobject)
    - [Remove-SNOWObject](#remove-snowobject)
- [RITM Variables](#ritm-variables)
- [Attachment API](#attachment-api)
- [Batch API](#batch-api)
- [Import API](#import-api)
- [ServiceCatalog API](#servicecatalog-api)
- [Invoke-SNOWRestMethod](#invoke-snowrestmethod)
- [All Functions](#all-functions)
  
# Authentication
Please see [REST API Security](https://docs.servicenow.com/bundle/tokyo-application-development/page/integrate/inbound-rest/concept/c_RESTAPI.html#d704019e666) for more information on permissions.  
The relevant ACLs/permissions will be required before being able to use the REST API.  
Some tables also require individual permissions depending on configuration.  
  
## Basic
```powershell
Set-SNOWAuth -Instance "InstanceName" -Credential (Get-Credential)
```

## OAuth
```powershell
$Credential = (get-credential)
$ClientID = "5370b72a1afc4212bdeee1ff81d91bf3"
$ClientSecret = "myClientSecret" | ConvertTo-SecureString -Force -AsPlainText
Set-SNOWAuth -Instance "InstanceName" -Credential $SnowCred -ClientId $clientID  -ClientSecret $ClientSecret -verbose
```
OAuth authentication works by initially making a request with credentials to get an access token.  
The access token is then stored in script scope.  Once it expires a refresh token is automatically used to obtain a new access token.
[More information can be seen here.](https://www.servicenow.com/community/developer-articles/video-how-to-authenticate-to-servicenow-rest-apis-using-oauth/ta-p/2330464)

> ❕ Please note that access token lifetimes should be no less than 5minutes (By default they are 30mins). This is due to a buffer period (for long running calls) being added in to the Assert-SNOWAuth private function.

## Rate Limit Handling
By default rate limiting is not handled.  
Standard ServiceNow policies have limits applied on an hourly basis (not rolling).  
If a rate limit is hit, an error will be thrown to state that this has happened, the rule number for the policy violation, and the time until the rate limit will reset.  
  
If you wish for the module to automatically handle these (e.g wait until the reset and then retry the command), please use ```-HandleRateLimiting``` on the Set-SNOWAuth command, but please be aware this could cause the command to 'hang' for up to 60 minutes depending on which policy has been triggered.  

## Proxy Authentication
By default, the module will attempt to detect if there is a proxy being used and it will apply default credentials if none are supplied.  
Credentials can alternativly be provided to Set-SNOWAuth with the ```-ProxyCredential``` parameter.  
Or to bypass detection and provide a specific proxy address ```-ProxyURI``` can also be used.  

### Bypassing a proxy
There is also a ```-BypassDefaultProxy``` parameter which will ignore any system configured proxy.

> ⚠️ **This parameter is only available to PoweShell Core users**

### Bypassing a proxy on 5.1
Because the above switch is only available to Core users, you will need to apply the bypass to the machine config.  
This can be done in several places.  

For example on windows, Under 'Network & Internet \ Proxy'
We can add the bypass when modifying the proxy settings as shown below:  
![proxy_bypass](images/ProxyBypass.png)

Alternatively (and depending on how your proxy is configured) you can also use system environment variables as per this [MS article](https://docs.microsoft.com/en-us/dotnet/api/system.net.http.httpclient.defaultproxy?view=net-5.0)  
Please note using this method, it may be case sensitive.  
If in doubt, use lower case for the env variable names e.g 'no_proxy'.  
You will need to reboot for these settings to take effect.  


# Table API
The Table API is one of the most commonly used, it supports [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) operations on any table within the platform.  

There are 4 core functions to use the Table API:
- [Get-SNOWObject](#get-snowobject)
- [Set-SNOWObject](#set-snowobject)
- [New-SNOWObject](#new-snowobject)
- [Remove-SNOWObject](#remove-snowobject)
  
All table functions are based on the above core functions and inherit the same basic parameters.  
They operate mostly the same way.  
They also have parameters mapped for properties in each respective table (for example, Get-SNOWUser has a -user_name parameter, amongst others).

Below I will cover each of these functions with examples, followed by a table specific function along side.

## Get-SNOWObject

### Direct record lookup
Every record in ServiceNow has a unique identifier called a sys_id, this can be used to lookup objects directly:

```powershell
Get-SNOWObject -Table "sys_user" -Sys_ID "7dad954b47a12110d3e5fa8bd36d43a8"
OR
Get-SNOWUser -Sys_ID "7dad954b47a12110d3e5fa8bd36d43a8"
```

### Queries
I would recommend familiarizing with the [query operators](https://docs.servicenow.com/csh?topicname=r_OpAvailableFiltersQueries.html&version=latest) in servicenow before proceeding.

```powershell
Get-SNOWObject -Table "sys_user" -Query "active=true^ORDERBYsys_updated_on"
OR
Get-SNOWUser -Query "active=true^ORDERBYDESCsys_updated_on"
```

Alternatively queries can be copy pasted straight from the GUI into any `Get-SNOW*` command:

![copy_paste_queries](images/copy_paste_queries.gif)

### Display values & reference links
Returned objects often contain referenced fields which by default will have two values, a link to the object and the sys_id value.

Rather than looking up that object to find out it's display name `-DisplayValue true` can be provided.  
Using this in tandem with `-ExcludeReferenceLinks` will also flatten the object and only return the display value.

Example:

```powershell
Get-SNOWUser -Limit 1 -DisplayValue true -ExcludeReferenceLinks
```
Possible values for `-DisplayValue` are 'true', 'false' (default) & 'all'

### Fields & Dot walking
The `-Fields` parameter can be used to lessen the burden on each call made.  
If you are retrieving an entire table but only need to know a few values you could do the following to make faster calls:

```powershell
Get-SNOWUser -Query "active=true" -Fields @('sys_id','user_name','email')
```

Dot walking can also ease the burden and save from making additional calls:

```powershell

$GetSNOWUser = @{
    Query = "user_name=billie.cowley"
    Fields = @(
        'sys_id'       
        'email'
        'manager'
        'manager.email'    
    )
    ExcludeReferenceLinks = $true
}
Get-SNOWUser @GetSNOWUser

# Returns:
sys_id        : 02826bf03710200044e0bfc8bcbe5d88
manager.email : krystle.stika@example.com
manager       : 02826bf03710200044e0bfc8bcbe5d7f
email         : billie.cowley@example.com
```

> ❕ Please note that dot-walking can is only supported by GET cmdlets. Servicenow does not support this action on SET commands.

### Pagination
All get commands will automatically paginate calls so that requests do not time out.  
By default 1000 records are returned in each request, until there are no more records left to fetch.  
Each `Get-SNOW*` command has both `-limit` and `-offset` which will allow pagination to be controlled manually if this is needed.

## Set-SNOWObject
`Set-SNOW*` Commands require a `-sys_id` to indicate which record to modify. This value can be piped by property name.  
If using `Set-SNOWObject` a `-table` must also be provided if the object is not being piped.

```powershell
$user = Get-SNOWObject -table "sys_user" -query "user_name=bruce.wayne"
$user | Set-SNOWObject -Properties @{middle_name="Thomas"}
OR
$user = Get-SNOWUser -user_name "bruce.wayne"
$user | Set-SNOWUser -middle_name "Thomas"
```

`-Properties` can be used on any `Set-SNOW` table command if the required properties are not present as parameters.
For example:
```powershell
$user | Set-SNOWUser -Properties @{city="Gotham"} -PassThru
```

### Encrypted fields
To set the value of an encrypted field `-InputDisplayValue` must be used.  
This will need to be manually applied while using `Set-SNOWObject`.  
For `Set-SNOWUser` it is automatically applied on the password field.

## New-SNOWObject

```powershell
$UserProperties = @{
    user_name = "Edward.Nigma"
    first_name = "Edward"
    last_name = "Nigma"
    middle_name = "Riddler"
    email = "Riddler@LegionOfDoom.com"
}
$NewUser = New-SNOWObject -Table "sys_user" -Properties $UserProperties -PassThru

OR

$UserProperties = @{
    user_name = "Edward.Nigma"
    first_name = "Edward"
    last_name = "Nigma"
    middle_name = "Riddler"
    email = "Riddler@LegionOfDoom.com"
    photo = "C:\Temp\TheRiddler.jpg"
}
$NewUser = New-SNOWUser @UserProperties -PassThru -Verbose
```

In the example above, `New-SNOWObject` only performs the basic 'create' action, this can be limited in some respects.  
New-SNOWUser on the other hand has been developed with quality of life improvements.  
In this case, the `photo` param makes a second call to attach the photo to the new user object after it has been created.

### Encrypted fields
To set the value of an encrypted field `-InputDisplayValue` must be used.

## Remove-SNOWObject
The majority of returned table objects, contain both a unique identifier (sys_id) and table name (sys_class_name) as part of their properties.  
To remove any object with these properties it can be piped as follows:
```powershell
$NewUser | Remove-SNOWObject
```
Alternatively objects can be removed directly with the table name and sys_id:
```powershell
Remove-SNOWObject -table "sys_user" -sys_id 7dad954b47a12110d3e5fa8bd36d43a8
```

> ❕ If a returned object does not have a sys_class_name there will be an accompanied `Remove-SNOW*` command specifically for that type of object.

# RITM Variables
> Please note, to use Get-SNOWRITMVariableSet you will need read access to the following tables:  
> sc_req_item, sc_item_option_mtom, sc_item_option, sc_item_option_new  
> It is possible to make a call without the correct permissions; specific fields may be omitted from the response and there may not be any errors.

You may use the service catalog quite a lot, the questions and values filled out by users on a catalog form are saved into separate tables from the RITM itself.  
As such there's a separate command to make retrieval of these variables much easier.  
This command will get all the variables associated to a single RITM.

```powershell
$RITM = Get-SNOWRITM -number RITM0010001
$RITM | Get-SNOWRITMVariableSet
OR
Get-SNOWRITMVariableSet -number RITM0010001
```

You can also set RITM variables in a similar manor:

```powershell
$RITM | Set-SNOWRITMVariable -Name "business_purpose" -Value "Test Value"
```

Please see function get-help examples for more.

# Attachment API
Please see the below example to upload an attachment, this can be applied to any table command that supports attachments:
```powershell
Get-SNOWUser -user_name "Bruce.Wayne" | New-SNOWAttachment -File "C:\temp\BatmanEnemies.csv"
```

Attachments can also be retrieved a simmilar way:
```powershell
Get-SNOWUser -user_name "Bruce.Wayne" | Get-SNOWAttachment -PassThru
```
Omitting `-PassThru` will return the attachment record, but not the attachment itself.  
While adding `-PassThru` will add the content into another property with the returned object.  

Alternatively if you wish to download the attachment directly to a file you can use the following:

```powershell
$User | Get-SNOWAttachment -OutputDestination "c:\super_secret_docs\" -Force
```
This will save the file into the destination folder with the original filename.   
Appending `-Force` will create the directory if it does not already exist.

If you wish to download the file and save with a different filename the following syntax can be used:
```powershell
$User | Get-SNOWAttachment -OutputDestination "c:\super_secret_docs\" -OutputFilename "Enemies.csv"
```

Uploading user photos is a similar process, however unlike regular attachments they are hidden.  
Due to this there's a separate function:

```powershell
$User | Set-SNOWUserPhoto -Filepath "C:\temp\Bruce.jpg"
```

Hidden attachments can still be seen using the `-DisregardSourceTable` parameter:

```powershell
$User | Get-SNOWAttachment -DisregardSourceTable | Remove-SNOWAttachment
```


# Batch API
The Batch API allows sending multiple requests but within the same call, reducing the overhead.  
All New-SNOW* and Set-SNOW* table commands in this module are supported.  
Set-SNOWUserPhoto, New-SNOWAttachment are also supported.  

Lets say as an example, we want to update all user email addresses based on first and last names.  
In my test instance I have 621 users.  
We could use `Set-SNOWUser` in a loop, and I tried this, but gave up after waiting 43 seconds to only get to the 50th user.

Now lets introduce `Invoke-SNOWBatch`, we can take the same code, and just wrap it with this command:

```powershell
$Users = Get-SNOWUser

Invoke-SNOWBatch -Scriptblock {
    ForEach ($User in $Users){
        $User | Set-SNOWUser -Email "$($User.first_name).$($User.last_name)@CompanyEmail.com"
    }
} -Parallel
```
Timing the above took only 8 seconds and made only 5 calls to the API.  
(The default setting is 150 items per batch, however this can be adjusted with `-BatchSize`)

Note:  
`-parallel` uses a bundled [Invoke-Parallel](https://github.com/RamblingCookieMonster/PowerShell/blob/master/Invoke-Parallel.ps1) all credit on that goes to [RamblingCookieMonster](https://github.com/RamblingCookieMonster)  

# Import API
Staging tables are often used as a way for importing data and creating transform maps into other tables.  
As an example, I have a CSV with 10 fictional movies and their key properties.  
In servicenow I have a  staging table, or import table called 'u_moviesimport' with a transform map which loads that data into a table with different column headings called 'u_custom_demo_table':

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
$Imports.result | Group-Object status | Select Count, Name

# OUTPUT:
Count Name
----- ----
    2 inserted
```

`New-SNOWImport` also supports the batching method shown above.

# ServiceCatalog API
There are many benefits of creating a request via the service catalog API, rather than say, just creating a request via the table API.  
For one, if you do it via the table API, you would have to create the request, requested item, any tasks that should be generated, set all the properties, assignment group and so on.  
Creating the same type of request via the service catalog however, would be just like a user logging that request through the portal, any workflows in the background will trigger normally, request, requested items, tasks will all spawn automatically as they normally would do.  
  
In this example, I'm opening a whitelist ip firewall request.  
The `-sys_id` provided to `New-SNOWSCCartItem` can be obtained by navigating to the desired catalog form in your web browser and copying the sys_id from the URL.  

```powershell
New-SNOWSCCartItem -Sys_ID "e91336da4fff0200086eeed18110c7a3" -Properties @{
    primary_contact  = "a8f98bb0eb32010045e1a5115206fe3a"
    cost_center      = "a581ab703710200044e0bfc8bcbe5de8"
    ip_range         = "127.0.0.1"
    business_purpose = "testing"
} -Checkout -PassThru
```

Other examples to interact with the service catalog cart:

```powershell
#View the cart
Get-SNOWSCCart

#Checkout the cart
Invoke-SNOWSCCart -Checkout -PassThru

#Empty the cart
Invoke-SNOWSCCart -Empty
```

# Invoke-SNOWRestMethod
This function is a sort of generic replacement/wrapper to Invoke-RestMethod. 
It's purpose is just to leverage the authentication set with Set-SNOWAuth to make REST calls to other API's in ServiceNow that may not yet be supported by this module.

```powershell
#Example GET command
$Response = Invoke-SNOWRestMethod -uri "api/now/v2/table/sys_user?sysparm_limit=1"

#Example POST command
$Body = @{first_name="john";last_name="smith"} | ConvertTo-json
$Response = Invoke-SNOWRestMethod -uri "api/now/v2/table/sys_user" -Method "POST" -Body $Body -Headers @{"Content-Type"="Application/Json"}
```

# Function Documentation
Further documentation can be found [here](functions/)