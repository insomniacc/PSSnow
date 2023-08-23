function Get-SNOWAttachment {
    <#
    .SYNOPSIS
        Gets attachments from servicenow.
    .DESCRIPTION
        Retrieves attachment records or binary data from either a direct lookup, parent object or query.
    .NOTES
        System limitations on uploaded files, such as maximum file size and allowed attachment types are configured within ServiceNow. Default max file size is 1024MB.
    .LINK
        https://github.com/insomniacc/PSSnow/blob/main/docs/functions/Get-SNOWAttachment.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_AttachmentAPI.html&version=latest
    .EXAMPLE
        Get-SNOWAttachment -Sys_ID a73f6d2447292110d3e5fa8bd36d4304
        Provide the sys_id of an attachment to look it up directly
    .EXAMPLE
        Get-SNOWAttachment -Sys_ID a73f6d2447292110d3e5fa8bd36d4304 -PassThru
        Downloads and returns the binary data for the attachment
    .EXAMPLE
        Get-SNOWAttachment -Sys_ID a73f6d2447292110d3e5fa8bd36d4304 -PassThru -OutputDestination "c:\temp"
        Downloads and saves the attachment into the specified destination folder with the original filename
    .EXAMPLE
        Get-SNOWAttachment -Sys_ID a73f6d2447292110d3e5fa8bd36d4304 -PassThru -OutputDestination "c:\temp" -OutputFilename "NewFilename.jpg"
        Downloads and saves the attachment into the specified destination with a different filename.
    .EXAMPLE
        Get-SNOWUser -user_name "bruce.wayne" | Get-SNOWAttachment -PassThru -OutputDestination "c:\temp"
        Pipe any Get-SNOW* table command to get all the associated attachments and save them into the output destination
    .EXAMPLE
        Get-SNOWUser -user_name "bruce.wayne" | Get-SNOWAttachment
        Pipe any Get-SNOW* table command to get all the associated attachment records
    #>

    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="High")]
    param (
        [Parameter(ParameterSetName='Attachment', Mandatory)]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [string]
        $Sys_ID,
        [Parameter(ValueFromPipeline, ParameterSetName='SNOWObject', Mandatory)]
        [ValidateScript({ 
            if(($_ | Get-Member -MemberType NoteProperty).Name -contains 'sys_id'){
                $True
            }else{
                Throw 'SNOWObject does not contain a sys_id property'
            }
        })]
        [PSCustomObject]
        $SNOWObject,
        [Parameter(ParameterSetName='Query',Mandatory)]
        [string]
        #Can be copied directly from the snow web gui
        $Query,
        [Parameter(ParameterSetName='Query')]
        [Parameter(ParameterSetName='SNOWObject')]
        [ValidateRange(0, [int]::MaxValue)]
        [int]
        $Offset,
        [Parameter(ParameterSetName='Query')]
        [Parameter(ParameterSetName='SNOWObject')]
        [ValidateRange(0, [int]::MaxValue)]
        [int]
        $Limit,
        [Parameter(ParameterSetName='Attachment')]
        [Parameter(ParameterSetName='SNOWObject')]
        [Parameter(ParameterSetName='Query')]
        [switch]
        $PassThru,
        [Parameter(ParameterSetName='Attachment')]
        [Parameter(ParameterSetName='SNOWObject')]
        [Parameter(ParameterSetName='Query')]
        [string]
        $OutputDestination,
        [Parameter(ParameterSetName='Attachment')]
        [Parameter(ParameterSetName='SNOWObject')]
        [Parameter(ParameterSetName='Query')]
        [string]
        $OutputFilename,
        [Parameter(ParameterSetName='Attachment')]
        [Parameter(ParameterSetName='SNOWObject')]
        [Parameter(ParameterSetName='Query')]
        [switch]
        $Force,
        [Parameter(ParameterSetName='Query')]
        [Parameter(ParameterSetName='SNOWObject')]
        [ValidateRange(1, [int]::MaxValue)]
        [int]
        $PaginationAmount = 50,
        [Parameter(ParameterSetName='Attachment')]
        [Parameter(ParameterSetName='SNOWObject')]
        [Parameter(ParameterSetName='Query')]
        [switch]
        $DisregardSourceTable
    )
    
    begin {
        $BaseURL = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v1/attachment"      
        $EnablePagination = $True
        
        if($OutputDestination -and -not $PassThru.IsPresent){
            $PassThru = [switch]$True
        }
    }
    
    process {
        $LookupType = if($PSCmdlet.ParameterSetName -eq 'SNOWObject'){
            <#
                A little unorthodox but I wanted an approach that lets a user pipe any servicenow object into this command to either get the associated attachments from a parent object OR if the object itself is an attachment, then the attachment record.
                This is done by taking the common keys from sys_attachment (not download_link because this doesn't show when viewing from the table API), and comparing to the keys on the input object
                If everything matches (not caring about any custom added fields) then it can be said this is an attachment, otherwise the sys_id will be used to lookup the parent.
            #>
            $Sys_ID = $SNOWObject.sys_id
            $SNOWObjectKeys = ($SNOWObject | Get-Member -MemberType NoteProperty).Name
            $Sys_AttachmentKeys = @(
                'size_bytes'
                'file_name'
                'table_name'
                'sys_id'
                'content_type'
                'size_compressed'
                'table_sys_id'
                'hash'
            )
            
            $ObjectTypeValidator = $Sys_AttachmentKeys.ForEach({$_ -in $SNOWObjectKeys})
            if($ObjectTypeValidator -NotContains $False ){
                'Attachment'
            }else{
                'Parent'
            }
        }else{
            $PSCmdlet.ParameterSetName
        }
        
        switch($LookupType){
            'Attachment'    {
                $URI = "$BaseURL/$Sys_ID"
                $EnablePagination = $False
            }
            'Parent'        {
                $URI = "$BaseURL`?sysparm_query=table_sys_id=$Sys_ID"
                if(-not $DisregardSourceTable.IsPresent){
                    $URI += "^table_name=$($SNOWObject.sys_class_name)"
                }
            }
            'Query'         {$URI = "$BaseURL`?sysparm_query=$Query"}
        }     
        
        if($Limit -and $Limit -le $PaginationAmount){
            $EnablePagination = $False
            $PaginationAmount = $Limit
        }
    
        if($Offset){
            $EnablePagination = $False
            $URI              = "$URI&sysparm_offset=$Offset"
        }
        
        if($LookupType -ne 'Attachment'){
            #? Always apply the limit (Default pagination or user defined)
            $URI = "$URI&sysparm_limit=$PaginationAmount"   
        }


        try{
            $Attachments = [System.Collections.ArrayList]@()
            $Attachments =  if($EnablePagination){
                                if($Limit){
                                    For($Offset = 0; $Offset -lt $Limit; $Offset+=$PaginationAmount){
                                        $Response = (Invoke-SNOWWebRequest -UseRestMethod -URI "$URI&sysparm_offset=$Offset").Result
                                        [void]$Attachments.Add($Response)
                                    }
                                    @($Attachments | ForEach-Object {$_}) | Select-Object -first $Limit
                                }else{
                                    $Offset = 0
                                    Do{
                                        $Response = Invoke-SNOWWebRequest -URI "$URI&sysparm_offset=$Offset"
                                        [void]$Attachments.Add(($Response.content | ConvertFrom-Json).Result)
                                        $Offset += $PaginationAmount
                                    }While($Response.Headers.Link -like "*rel=`"next`"*")
                                    @($Attachments | ForEach-Object {$_})
                                }
                            }else{
                                #? If this is a direct 'attachment' lookup, we already have the full attachment object, and PassThru is specified then we don't need to get the record again.
                                if(-not ($PSCmdlet.ParameterSetName -eq 'SNOWObject' -and $LookupType -eq 'Attachment' -and $PassThru.IsPresent)){
                                    (Invoke-SNOWWebRequest -UseRestMethod -URI $URI).Result
                                }else{
                                    $SNOWObject
                                }
                            }
        }catch{
            Write-Error "Unable to get attachment record/s. $($_.Exception.message)"
            Return
        }

        if($PassThru.IsPresent){
            #? Show progress for file downloads
            $ProgressPreference = "Continue"
            $Attachments = Foreach($Attachment in $Attachments){
                if(-not $OutputDestination){
                    $OutputDestination = $PWD
                }
                $OutFilepath = if($OutputFilename){
                    Join-Path -Path $OutputDestination -ChildPath $OutputFilename
                }else{
                    Join-Path -Path $OutputDestination -ChildPath $Attachment.file_name
                }

                if($Force.IsPresent){
                    [void](New-Item $OutputDestination -Force -ItemType "Directory" -Verbose:$False)
                }

                if($PSBoundParameters.OutputDestination -or $PSBoundParameters.OutputFilename){                    
                    if(-not $Force.IsPresent){
                        if(Test-Path $OutFilepath){
                            $PSCmdlet.ShouldProcess($OutFilepath,'Overwrite existing file')
                        }
                    }
                    $Attachment | Add-Member -MemberType NoteProperty -Name 'output_filepath' -Value $OutFilepath -Force
                    Invoke-SNOWWebRequest -UseRestMethod -URI $Attachment.download_link -OutFile $OutFilepath
                    $Attachment
                }else{
                    $Attachment | Add-Member -MemberType NoteProperty -Name 'content' -Value (Invoke-SNOWWebRequest -UseRestMethod -URI $Attachment.download_link) -Force
                    $Attachment
                }   
            }
        }
        
        Return $Attachments
    }
}