function Set-SNOWWebConcourseState {
    <#
    .SYNOPSIS
        Sets the current application or update set in a ServiceNow web session.

    .DESCRIPTION
        This function changes the current application or update set in an active ServiceNow web session.
        It uses the ServiceNow Concourse Picker API to switch the context of the session.
        
    .PARAMETER ApplicationId
        The sys_id of the application to set as the current application.
        This parameter is part of the 'ApplicationId' parameter set.

    .PARAMETER ScopeName
        The scope name of the application to set as the current application.
        This parameter is part of the 'ScopeName' parameter set.
        
    .PARAMETER UpdateSet
        The sys_id of the update set to set as the current update set.
        This parameter is part of the 'UpdateSet' parameter set.
        
    .EXAMPLE
        Set-SNOWWebConcourseState -ScopeName "global"
        
        Sets the current application to 'global' using the scope name.
        
    .EXAMPLE
        Set-SNOWWebConcourseState -ApplicationId "2329f897dbdcab00d5c07109af9619a2"
        
        Sets the current application using its sys_id.
        
    .EXAMPLE
        Set-SNOWWebConcourseState -UpdateSet "9a4b095f87902110929c6d73cebb3598"
        
        Sets the current update set to the one with the specified sys_id.
        
    .NOTES
        This function should be used in conjunction with a valid ServiceNow web session. (See: Set-SNOWAuth -UseWebSession)
        Using without a session should be done with caution if the user account is logged in elsewhere.

    .OUTPUTS
        Returns the updated concourse state after the operation.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding(DefaultParameterSetName = 'ScopeName')]
    param (
        # The sys_id of the application to set as the current application in the ServiceNow session
        [Parameter(Mandatory = $true, ParameterSetName = 'ApplicationId')]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [string]
        $ApplicationId,

        # The scope name of the application to set as the current application in the ServiceNow session
        [Parameter(Mandatory = $true, ParameterSetName = 'ScopeName')]
        [string]
        $ScopeName,
        
        # The sys_id of the update set to set as the current update set in the ServiceNow session
        [Parameter(Mandatory = $true, ParameterSetName = 'UpdateSet')]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [string]
        $UpdateSet
    )

    # Get current session state
    $ConcourseState = Get-SNOWWebConcourseState
    
    $pickerBase = 'api/now/ui/concoursepicker'
    
    # Construct the request parameters based on parameter set
    $requestParams = switch ($PSCmdlet.ParameterSetName) {
        'ApplicationId' {
            @{
                Uri           = "$pickerBase/application"
                BodyProperty  = 'app_id'
                CurrentValue  = $ConcourseState.Current.currentApplication.sysId
                TargetValue   = $ApplicationId
                AvailableList = $ConcourseState.ConcourseList.availableApplications
                MatchProperty = 'sysId'
            }
        }
        'ScopeName' {
            # Global is a special case
            if($ScopeName -eq 'global') {
                $TargetValue = 'Global'
                $MatchProperty = "name"
                $CurrentValue = $ConcourseState.Current.currentApplication.name
            }else{
                $TargetValue = $ScopeName
                $MatchProperty = "scopeName"
                $CurrentValue = $ConcourseState.Current.currentApplication.scopeName
            }
            @{
                Uri           = "$pickerBase/application"
                BodyProperty  = 'app_id'
                CurrentValue  = $CurrentValue
                TargetValue   = $TargetValue
                AvailableList = $ConcourseState.ConcourseList.availableApplications
                MatchProperty = $MatchProperty
            }
        }
        'UpdateSet' {
            @{
                Uri           = "$pickerBase/updateset"
                BodyProperty  = 'sysId'
                CurrentValue  = $ConcourseState.Current.currentUpdateSet.name
                TargetValue   = $UpdateSet
                AvailableList = $ConcourseState.ConcourseList.availableUpdateSets
                MatchProperty = 'sysId'
            }
        }
    }

    # If current value is already set, return existing session state
    if ($requestParams.CurrentValue -eq $requestParams.TargetValue) {
        Write-Verbose "$($PSCmdlet.ParameterSetName) is already set to $($requestParams.TargetValue)"
        return $ConcourseState
    }

    Write-Verbose "Setting $($PSCmdlet.ParameterSetName.ToLower()) to $($requestParams.TargetValue)"
    
    # Find the details in the available items
    $details = $requestParams.AvailableList | 
    Where-Object { $_.$($requestParams.MatchProperty) -eq $requestParams.TargetValue }
        
    if (-not $details) {
        Write-Warning "$($PSCmdlet.ParameterSetName) '$($requestParams.TargetValue)' not found in available items"
        return $ConcourseState
    }

    # Construct and send the request
    $body = @{
        $($requestParams.BodyProperty) = "$($details.sysId)"
    } | ConvertTo-Json
    
    $params = @{
        Uri           = $requestParams.Uri
        Method        = "PUT"
        Body          = $body
        ContentType   = "application/json"
        UseRestMethod = $true
    }
    $response = Invoke-SNOWWebRequest @params
    if ($response.result) {
        Write-Verbose "Successfully set $($PSCmdlet.ParameterSetName.ToLower()) to $($requestParams.TargetValue)"
        return Get-SNOWWebConcourseState
    }
    else {
        Write-Warning "Failed to set $($PSCmdlet.ParameterSetName.ToLower()) to $($requestParams.TargetValue)"
        return $ConcourseState
    }
}
