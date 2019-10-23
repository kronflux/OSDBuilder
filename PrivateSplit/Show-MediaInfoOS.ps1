function Show-MediaInfoOS {
    [CmdletBinding()]
    Param ()
    Write-Host '========================================================================================' -ForegroundColor DarkGray
    Write-Host -ForegroundColor Green "OSMedia Information"
    Write-Host "-OSMediaName:   $OSMediaName" -ForegroundColor Yellow
    Write-Host "-OSMediaPath:   $OSMediaPath" -ForegroundColor Yellow
    Write-Host "-OS:            $OS"
    Write-Host "-WinPE:         $WinPE"
    Write-Host "-Info:          $Info"
    Write-Host "-Logs:          $Info\logs"
}
