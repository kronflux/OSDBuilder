function Show-WorkingInfoOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    Write-Verbose '19.1.1 Working Information'
    #===================================================================================================
    Write-Host '========================================================================================' -ForegroundColor DarkGray
    Write-Host -ForegroundColor Green "Working Information"
    Write-Host "-WorkingName:   $WorkingName" -ForegroundColor Yellow
    Write-Host "-WorkingPath:   $WorkingPath" -ForegroundColor Yellow
    Write-Host "-OS:            $OS"
    Write-Host "-WinPE:         $WinPE"
    Write-Host "-Info:          $Info"
    Write-Host "-Logs:          $Info\logs"
    Write-Host '========================================================================================' -ForegroundColor DarkGray
}
