function Import-DefaultParams {
    <#
    .SYNOPSIS
        Used to inherit default parameters from a base function
    .DESCRIPTION
        Builds a parameter dictionary based on the existing parameters of the supplied function name
    .NOTES
        Can be used to populate a dynamic parameter block from a proxy function
    .EXAMPLE
        DynamicParam { Import-DefaultParams }
        Used in a child function to import the parents parameters
    #>
    
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [string]
        $TemplateFunction,
        [Parameter()]
        [array]
        $Exclusions = @("table"),
        [Parameter()]
        [switch]
        $AsStringArray
    )
    $BaseCommand = Get-Command $TemplateFunction
    $Common = @(
                    [System.Management.Automation.PSCmdlet]::CommonParameters;
                    [System.Management.Automation.PSCmdlet]::OptionalCommonParameters;
                    $Exclusions
                )

    if(-not $BaseCommand){
        Write-Error "Unable to find function $TemplateFunction" -ErrorAction Stop
    }

    if($AsStringArray.IsPresent){
        return $BaseCommand.Parameters.Keys
    }else{
        $ParamDictionary = [RuntimeDefinedParameterDictionary]::new()
        $BaseCommand.Parameters.GetEnumerator().foreach{
            $Val = $_.value
            $Key = $_.key
            if ($Key -notin $Common)
            {
                $param = [RuntimeDefinedParameter]::new(
                    $key, $val.parameterType, $val.attributes)
                $ParamDictionary.add($key, $param)
            }
        }
        return $ParamDictionary
    }
}