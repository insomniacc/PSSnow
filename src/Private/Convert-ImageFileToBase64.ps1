function Convert-ImageFileToBase64{
    param (
        $Filepath
    )

    #ps 5.1
    #$mimetype = [System.Web.MimeMapping]::GetMimeMapping($Filepath)

    Return [System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes($filePath))
}

