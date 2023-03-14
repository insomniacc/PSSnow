[CmdletBinding()]
Param(
    [Parameter(Mandatory,ValueFromPipeline)]
    [string]
    $TableName,
    [Parameter(ParameterSetName='FunctionName')]
    [ValidateScript({
        if($_ -like "*-*"){
            $AllowedVerbs =  @('Get','New','Remove','Set')
            if($_.split('-')[0] -in $AllowedVerbs){
                $True
            }else{
                Throw "FunctionName must start with one of the following verbs: $($AllowedVerbs -join ',' )"
            }
        }else{
            Throw "FunctionName must follow the standard verb-noun format."
        }
    })]
    [string]
    $FunctionName,
    [Parameter()]
    [string]
    $OutputPath = "$PSScriptRoot\..\src\Public\table",
    [Parameter(ParameterSetName='FunctionType')]
    [ValidateSet('GET','NEW','REMOVE','SET')]
    [string]
    $FunctionType = 'GET',
    [Parameter()]
    [switch]
    $AddToManifest,
    [Parameter()]
    [switch]
    $ParamLengthValidation
)

begin {
    Push-Location -Path $PWD
    cd $PSScriptRoot
}

process {
    #todo this script is not pretty, in fact it's terrible so don't judge me! it works and serves a purpose for now. It needs a full revise, requirements, pseudo code and full refactor.

    if($PSCmdlet.ParameterSetName -eq 'FunctionName'){
        $FunctionType = $FunctionName.split('-')[0]
    }

    Write-Verbose "Getting boiler plate from: $("Boilerplate_Table_$FunctionType.txt")"
    $Boilerplate = Get-Content "Boilerplate_Table_$FunctionType.txt" | out-string

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
        }while($Table.super_class -NotLike "")
        if($Tables.count -gt 1){
            Write-Verbose "Extends from tables: $(($Tables | Where-Object {$_ -NotLike $TableName}) -join ",")"
        }

        $Columns = ForEach($Table In $Tables){
            Get-SNOWObject -table "sys_dictionary" -Query "name=$Table^elementISNOTEMPTY" -ErrorAction STOP
        }

        $GlobalIgnoredTypes = @()
        $GlobalIgnoredColumns = @('wf_activity')

        $Columns = $Columns | Where-Object {
            $_.active -eq "true" -and 
            $_.element -NotLike "sys_*" -and 
            $_.internal_type.value -NotIn $GlobalIgnoredTypes -and 
            $_.element -notin $GlobalIgnoredColumns
        }
        $Indent = "`n        "
        $Params = ""
        :column foreach($Column in $Columns){
            switch ($FunctionType) {
                'GET' {
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
                }
                'SET' {
                    $IgnoredTypes = @()

                    if([System.Convert]::ToBoolean($Column.read_only)){
                        Write-Verbose "'$($Column.element)' param skipped. Reason: ReadOnly"
                        Continue column
                    }
                    
                    if($Column.dynamic_creation -eq "true"){
                        Write-Verbose "'$($Column.element)' param skipped. Reason: DynamicCreation"
                        Continue column
                    }

                    #Maximum Length
                    if($Column.max_length){
                        $ValidateLength = "$Indent[ValidateLength(0, $($Column.max_length))]"
                    }else{
                        $ValidateLength = ""
                    }
                }
                'NEW' {
                    $IgnoredTypes = @()

                    #if(-not [System.Convert]::ToBoolean($Column.display)){
                    #    Write-Verbose "'$($Column.element)' param skipped. Reason: Display=false"
                    #    Continue column
                    #}

                    if([System.Convert]::ToBoolean($Column.read_only)){
                        Write-Verbose "'$($Column.element)' param skipped. Reason: ReadOnly"
                        Continue column
                    }

                    if($Column.dynamic_creation -eq "true"){
                        Write-Verbose "'$($Column.element)' param skipped. Reason: DynamicCreation"
                        Continue column
                    }

                    #Maximum Length
                    if($Column.max_length){
                        $ValidateLength = "$Indent[ValidateLength(0, $($Column.max_length))]"
                    }else{
                        $ValidateLength = ""
                    }

                    #Mandatory
                    if([System.Convert]::ToBoolean($Column.mandatory)){
                        $Mandatory = "Mandatory"
                    }else{
                        $Mandatory = ""
                    }
                    
                    #todo see if its possible to also leverage the following: dynamic_ref_qual,dependent_on_field,dynamic_creation,dynamic_creation_script,use_dynamic_default,dynamic_default_value,use_reference_qualifier,reference_qual
                }
            }

            if($Column.internal_type.value -in $IgnoredTypes){
                Write-Verbose "'$($Column.element)' param skipped. Reason: IgnoredTypes [$($Column.internal_type.value)]"
                Continue column
            }
            
            $Alias = $Column.column_label.ToLower() -Replace '[^0-9A-Z]','_'
            if($Alias -NotLike $Column.element){
                $Alias = "$Indent[alias('$Alias')]"
            }else{
                $Alias = ""
            }

            #type mappings
            $PSType = switch ($Column.internal_type.value) {
                'boolean' {
                    "$Indent[boolean]"
                    $ValidateLength = ""
                }
                'reference' {
                    "$Indent[string]"
                    $ValidateLength = ""
                }
                default {"$Indent[string]"}
            }

            if(-not $ParamLengthValidation.IsPresent){
                $ValidateLength = ""
            }
            
            $Params += "$Indent[Parameter($Mandatory)]$ValidateLength$Alias$PSType$Indent`$$($Column.element),"
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