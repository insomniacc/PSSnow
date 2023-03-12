function Get-SNOWAttachment {
    <#
    .SYNOPSIS
        Gets attachments from servicenow.
    .DESCRIPTION
        Retrieves attachment records or binary data from either a direct lookup, parent object or query.
    .NOTES
        System limitations on uploaded files, such as maximum file size and allowed attachment types are configured within ServiceNow. Default max file size is 1024MB.
    .LINK
        https://developer.servicenow.com/dev.do#!/reference/api/tokyo/rest/c_AttachmentAPI
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

    [CmdletBinding()]
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
        [string]
        $OutputFilename,
        [Parameter(ParameterSetName='Attachment')]
        [Parameter(ParameterSetName='SNOWObject')]
        [Parameter(ParameterSetName='Query')]
        [switch]
        $Force
    )
    
    begin {
        Assert-SNOWAuth
        $BaseURL = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v1/attachment"
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
                'attachment'
            }else{
                'parent'
            }
        }else{
            $PSCmdlet.ParameterSetName
        }
        
        switch($LookupType){
            'attachment' {$URI = "$BaseURL/$Sys_ID"}
            'parent' {$URI = "$BaseURL`?sysparm_query=table_sys_id=$Sys_ID"}
            'query' {
                #todo query
            }
        }                  
        
        $Attachments = (Invoke-RestMethod -URI $URI -Credential $Script:SNOWAuth.Credential).Result

        if($PassThru.IsPresent){
            $Attachments = $Attachments.ForEach({
                if(-not $OutputDestination){
                    $OutputDestination = $PWD
                }
                $OutFilepath = if($OutputFilename){
                    Join-Path -Path $OutputDestination -ChildPath $OutputFilename
                }else{
                    Join-Path -Path $OutputDestination -ChildPath $_.file_name
                }

                if($Force.IsPresent){
                    [void](New-Item $OutputDestination -Force -ItemType "Directory" -Verbose:$False)
                }

                if($PSBoundParameters.OutputDestination -or $PSBoundParameters.OutputFilename){
                    $DownloadSplat = @{
                        OutFile = $OutFilepath
                    }
                }else{
                    $DownloadSplat = @{}
                }

                Invoke-RestMethod -URI "$URI/file" -Credential $Script:SNOWAuth.Credential @DownloadSplat
            })
        }
        
        Return $Attachments
    }
}