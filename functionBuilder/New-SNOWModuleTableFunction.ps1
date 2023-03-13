[CmdletBinding()]
Param(
    [Parameter(Mandatory,ValueFromPipeline)]
    [string]
    $TableName,
    [Parameter()]
    [string]
    $FunctionName,
    [Parameter()]
    [string]
    $OutputPath = "$PSScriptRoot\..\src\Public\table",
    [Parameter()]
    [ValidateSet('GET','NEW','REMOVE','SET')]
    [string]
    $FunctionType = 'GET',
    [Parameter()]
    [switch]
    $AddToManifest
)

begin {
    Push-Location -Path $PWD
    cd $PSScriptRoot
    Write-Verbose "Getting boiler plate from: $("Boilerplate_Table_$FunctionType.txt")"
    $Boilerplate = Get-Content "Boilerplate_Table_$FunctionType.txt" | out-string
}

process {
    #? Create function name in pascal case based on table name
    if(-not $FunctionName){
        $FunctionName = $TableName -Replace '[^0-9A-Z]',' '
        $FunctionName = (Get-Culture).TextInfo.ToTitleCase($FunctionName) -Replace ' '
        $FunctionName = "Get-SNOW$FunctionName"
    }
    $TableName = $TableName.ToLower()

    #? Create param block based on table properties
    if($FunctionType -ne "REMOVE"){
        # Get all tables extended from
        $TableLookup = $TableName
        $Tables = @()
        Do{
            $Tables += $TableLookup
            $Table = Get-SNOWObject -table "sys_db_object" -Query "name=$TableLookup" -Fields @('name','super_class') -displayvalue True -ExcludeReferenceLinks
            $TableLookup = $Table.super_class
        }while($Table.super_class -notlike "")
        if($Tables.count -gt 1){
            Write-Verbose "Extends from tables: $(($Tables | Where-Object {$_ -notlike $TableName}) -join ",")"
        }

        $Columns = ForEach($Table In $Tables){
            Get-SNOWObject -table "sys_dictionary" -Query "name=$Table^elementISNOTEMPTY" -Fields @('element','internal_type') -ErrorAction STOP
        }

        $IgnoredColumns = @(
            'wf_activity'
        )
        if($FunctionType -eq 'GET'){
            $IgnoredTypes = @(
                'glide_date'
                'glide_date_time'
                'date_time'
                'glide_time'
                'glide_utc_time'
                'schedule_date_time'
                'datetime'
                'insert_timestamp'
                'calendar_date_time'
                'date'
                'due_date'
                'time'
                'glide_precise_time'
                'password'
                'email_script'
                'script_client'
                'script'
            )
        }else{
            $IgnoredTypes = @()
        }

        $Columns = $Columns | Where-Object {$_.element -NotLike "sys_*" -and $_.internal_type.value -NotIn $IgnoredTypes -and $_.element -notin $IgnoredColumns}
        $Indent = "`n        "
        $Params = ""

        switch ($Columns) {
            {$_.internal_type.value -eq 'boolean'} {$Params += "$Indent[Parameter()]$Indent[boolean]$Indent`$$($_.element),"}
            default {$Params += "$Indent[Parameter()]$Indent[string]$Indent`$$($_.element),"}
        }
        $Params = $Params.TrimEnd(',') + "`n    "
        #Write-Verbose "Parameters: $($Columns.element -join ',')"
    }

    #? Replace placeholders
    $Placeholders = ([regex]::Matches($Boilerplate, '{{.*}}')).value.replace('{','').replace('}','') | Sort-Object -Unique
    Foreach ($Placeholder in $Placeholders){
        $Boilerplate = $Boilerplate -replace "{{$Placeholder}}",(Get-Variable -Name $Placeholder -ValueOnly -ErrorAction SilentlyContinue)
    }

    #? Output new function
    $OutFile = Join-Path -Path $OutputPath -ChildPath "$FunctionName.ps1"
    if(Test-Path $OutFile){
        Throw "$OutFile already exists"
    }else{
        $ForceSplat = @{
            Force = $true
        }
    }
    Set-Content -Path $OutFile -Value $Boilerplate @ForceSplat
    Write-Verbose "Output to $OutFile"

    if($AddToManifest.IsPresent){
        $ManifestPath = $OutputPath -replace "Public\\table","PSServiceNow.psd1"
        $ManifestScript = (get-content $ManifestPath | out-string)
        $Manifest = Invoke-Expression -Command $ManifestScript
        Update-ModuleManifest -Path $ManifestPath -FunctionsToExport ($Manifest.FunctionsToExport + $FunctionName)
    }
    Write-Verbose "Added $FunctionName to PSServiceNow.psd1"
}

End {
    Pop-Location
}