Function Format-Hashtable {
    Param(
        [Parameter(Mandatory)]
        [hashtable]
        $Hashtable,
        [switch]
        $KeysToLowerCase
    )

    BEGIN {
        $OutputHashtable = @{}   
    }

    PROCESS {
        if($KeysToLowerCase.IsPresent){
            foreach ($Key in $Hashtable.Keys) {
                $OutputHashtable.Add($Key.ToLower(), $Hashtable[$Key])
            }
        }
    }

    END {
        Return $OutputHashtable
    }
}