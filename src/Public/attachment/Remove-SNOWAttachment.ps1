function Remove-SNOWAttachment {
    <#
    .SYNOPSIS
        Removes attachments from servicenow.
    .DESCRIPTION
        Deletes an attachment from servicenow.
    .LINK
        https://github.com/insomniacc/PSServiceNow/blob/main/docs/functions/Remove-SNOWAttachment.md
    .LINK
        https://docs.servicenow.com/csh?topicname=c_AttachmentAPI.html&version=latest
    .EXAMPLE
        Remove-SNOWAttachment -Sys_ID a73f6d2447292110d3e5fa8bd36d4304
        Removes a single attachment by sys_id
    .EXAMPLE
        Get-SNOWUser -user_name "bruce.wayne" | Get-SNOWAttachment | Remove-SNOWAttachment -Verbose
        Removes all attachments on the associated parent object
    #>

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateScript({ $_ | Confirm-SysID -ValidateScript })]
        [string]
        #The SysID of the attachment record to be deleted
        $Sys_ID
    )
    
    begin {
        Assert-SNOWAuth
        $BaseURL = "https://$($script:SNOWAuth.instance).service-now.com/api/now/v1/attachment/"

        $AuthSplat = @{
            Credential = $Script:SNOWAuth.Credential
        }
    }
    
    process {
        try{
            if($PSCmdlet.ShouldProcess($URI,'DELETE')){
                Invoke-RestMethod -URI "$BaseURL$Sys_ID" -Method "DELETE" @AuthSplat
            }
        }catch{
            Write-Error "$($_.Exception.Message) [$URI]"
        }
    }
}