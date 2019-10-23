function Show-OSDBuilderHomeOnline {
    [CmdletBinding()]
    Param ()

    $statuscode = try {(Invoke-WebRequest -Uri $OSDBuilderURL -UseBasicParsing -DisableKeepAlive).StatusCode}
    catch [Net.WebException]{[int]$_.Exception.Response.StatusCode}
    if (!($statuscode -eq "200")) {
    } else {
        $LatestModuleVersion = @()
        $LatestModuleVersion = Invoke-RestMethod -Uri $OSDBuilderURL
        
        if ([System.Version]$($LatestModuleVersion.Version) -eq [System.Version]$OSDBuilderVersion) {
            #Write-Host "OSDBuilder Module $OSDBuilderVersion" -ForegroundColor Green
            foreach ($line in $($LatestModuleVersion.LatestUpdates)) {Write-Host $line -ForegroundColor DarkGray}
            Write-Host ""
            Write-Host "New Links:" -ForegroundColor Cyan
            foreach ($line in $($LatestModuleVersion.NewLinks)) {Write-Host $line -ForegroundColor Gray}
            Write-Host ""
            Write-Host "Helpful Links:" -ForegroundColor Cyan
            foreach ($line in $($LatestModuleVersion.HelpfulLinks)) {Write-Host $line -ForegroundColor Gray}
        } elseif ([System.Version]$($LatestModuleVersion.Version) -lt [System.Version]$OSDBuilderVersion) {
            #Write-Host "OSDBuilder Module $OSDBuilderVersion" -ForegroundColor Green
            Write-Warning "OSDBuilder $OSDBuilderVersion is a Preview Version"
            Write-Host "Release Version: $($LatestModuleVersion.Version)" -ForegroundColor DarkGray
            foreach ($line in $($LatestModuleVersion.LatestUpdates)) {Write-Host $line -ForegroundColor DarkGray}
            Write-Host ""
            Write-Host "New Links:" -ForegroundColor Cyan
            foreach ($line in $($LatestModuleVersion.NewLinks)) {Write-Host $line -ForegroundColor Gray}
            Write-Host ""
            Write-Host "Helpful Links:" -ForegroundColor Cyan
            foreach ($line in $($LatestModuleVersion.HelpfulLinks)) {Write-Host $line -ForegroundColor Gray}
        } else {
            Write-Host "PowerShell Gallery: $($LatestModuleVersion.Version)" -ForegroundColor Gray
            #Write-Host "Installed Version: $OSDBuilderVersion" -ForegroundColor DarkGray
            Write-Warning "Updated OSDBuilder Module on PowerShell Gallery"
            foreach ($line in $($LatestModuleVersion.PSGallery)) {Write-Host $line -ForegroundColor DarkGray}
            Write-Host "Update Module Command: OSDBuilder -Update" -ForegroundColor Cyan
        }
    }  
}
