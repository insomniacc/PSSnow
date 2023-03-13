function ConvertTo-QueryString {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [String]
        $BaseURL,
        [Parameter()]
        $QueryParameters
    )

    $QueryCollection = [System.Web.HttpUtility]::ParseQueryString('')
    $URI = [System.UriBuilder]$BaseURL

    if($QueryParameters){
        if($QueryParameters.gettype().name -eq "Hashtable"){
            foreach($Property in $QueryParameters.GetEnumerator()){
                if($Property.Value){
                    $QueryCollection.Add($Property.key,$Property.Value)
                }
            }
        }elseif($QueryParameters.gettype().name -in @("DictionaryEntry","Object[]")){
            foreach($Property in $QueryParameters){
                if($Property.Value){
                    $QueryCollection.Add($Property.key,$Property.Value)
                }
            }
        }
    }

    $URI.Query = $QueryCollection.ToString()
    Return $URI.URI.OriginalString
}