function ConvertTo-QueryString {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [String]
        $BaseURL,
        [Parameter()]
        $QueryParameters
    )
    try{
        $QueryCollection = [System.Web.HttpUtility]::ParseQueryString('')
        $URI = [System.UriBuilder]$BaseURL
    
        if($QueryParameters){
            if($QueryParameters.GetType().name -eq "Hashtable"){
                foreach($Property in $QueryParameters.GetEnumerator()){
                    if($Property.Value){
                        $QueryCollection.Add($Property.key,$Property.Value)
                    }
                }
            }elseif($QueryParameters.GetType().name -in @("DictionaryEntry","Object[]")){
                foreach($Property in $QueryParameters){
                    if($Property.Value){
                        $QueryCollection.Add($Property.key,$Property.Value)
                    }
                }
            }
        }
    
        $URI.Query = $QueryCollection.ToString()
        if($URI.Query){
            Return $URI.URI.OriginalString
        }else{
            Return $URI.URI.OriginalString + "?"
        }
    }catch{
        #If auth has not been set, it's possible a bad URI has been passed to this function so we'll run the auth check in this instance
        if($_.Exception.message -like "*Invalid URI: The hostname could not be parsed*"){
            Assert-SNOWAuth
        }
        
        #If the auth check passes or for all other reasons, throw the original error
        Throw $_
    }
}