function Update-CumulativePE {
    [CmdletBinding()]
    Param (
        [switch]$Force
    )
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($SkipUpdates) {Return}
    if ($SkipUpdatesPE) {Return}
    if ($SkipUpdatesPELCU) {Return}
    if ($null -eq $OSDUpdateLCU) {Return}
    #===================================================================================================
    #   Update WinPE
    #===================================================================================================
    if ($OSMajorVersion -ne 10) {
        $OSDUpdateLCU = $OSDUpdateLCU | Where-Object {$_.OSDWinPE -eq $true}
        if ($Force.IsPresent) {Return}
    }
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: (LCU) Latest Cumulative Update"
    if ($OSBuild -ge 18362) {
        Write-Warning "Skipping Update for this version of Windows"
        Return
    }

    foreach ($Update in $OSDUpdateLCU) {
        $UpdateLCU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {($_.FullName -like "*$($Update.Title)*") -and ($_.Name -match "$($Update.FileName)")}).FullName

        if ($null -eq $UpdateLCU) {Continue}
        if (!(Test-Path "$UpdateLCU")) {Write-Warning "Not Found: $UpdateSSU"; Continue}

        if (!($Force.IsPresent)) {
            $SessionsXmlInstall = "$MountWinPE\Windows\Servicing\Sessions\Sessions.xml"
            if (Test-Path $SessionsXmlInstall) {
                [xml]$XmlDocument = Get-Content -Path $SessionsXmlInstall
                if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.FileKBNumber)*" -and $_.targetState -eq 'Installed'}) {
                    Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                    Continue
                }
            }
        }

        Write-Host -ForegroundColor Cyan "INSTALLING        " -NoNewline
        Write-Host -ForegroundColor Gray "$($Update.Title) - $($Update.FileName)"

        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Update-CumulativePE-KB$($Update.KBNumber)-WinPE.log"
        Write-Verbose "CurrentLog: $CurrentLog"
        Try {Add-WindowsPackage -Path "$MountWinPE" -PackagePath "$UpdateLCU" -LogPath "$CurrentLog" | Out-Null}
        Catch {
            $ErrorMessage = $_.Exception.$ErrorMessage
            Write-Warning "$CurrentLog"
            Write-Host "$ErrorMessage"
            if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
        }
        if (!($OSVersion -like "6.1.7601.*")) {
            $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-DismCleanupImage-WinPE.log"
            Write-Verbose "CurrentLog: $CurrentLog"
            if ($SkipComponentCleanup) {
                Write-Warning "Skip: -SkipComponentCleanup Parameter was used"
            } else {
                Dism /Image:"$MountWinPE" /Cleanup-Image /StartComponentCleanup /ResetBase /LogPath:"$CurrentLog" | Out-Null
            }
        }
    }
    #===================================================================================================
    #   Update WinRE
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinRE: (LCU) Latest Cumulative Update"
    foreach ($Update in $OSDUpdateLCU) {
        $UpdateLCU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {($_.FullName -like "*$($Update.Title)*") -and ($_.Name -match "$($Update.FileName)")}).FullName

        if ($null -eq $UpdateLCU) {Continue}
        if (!(Test-Path "$UpdateLCU")) {Write-Warning "Not Found: $UpdateSSU"; Continue}

        if (!($Force.IsPresent)) {
            $SessionsXmlInstall = "$MountWinRE\Windows\Servicing\Sessions\Sessions.xml"
            if (Test-Path $SessionsXmlInstall) {
                [xml]$XmlDocument = Get-Content -Path $SessionsXmlInstall
                if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.FileKBNumber)*" -and $_.targetState -eq 'Installed'}) {
                    Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                    Continue
                }
            }
        }

        Write-Host -ForegroundColor Cyan "INSTALLING        " -NoNewline
        Write-Host -ForegroundColor Gray "$($Update.Title) - $($Update.FileName)"

        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Update-CumulativePE-KB$($Update.KBNumber)-WinRE.log"
        Write-Verbose "CurrentLog: $CurrentLog"
        Try {Add-WindowsPackage -Path "$MountWinRE" -PackagePath "$UpdateLCU" -LogPath "$CurrentLog" | Out-Null}
        Catch {
            $ErrorMessage = $_.Exception.$ErrorMessage
            Write-Warning "$CurrentLog"
            Write-Host "$ErrorMessage"
            if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
        }
        if (!($OSVersion -like "6.1.7601.*")) {
            $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-DismCleanupImage-WinRE.log"
            Write-Verbose "CurrentLog: $CurrentLog"
            if ($SkipComponentCleanup) {
                Write-Warning "Skip: -SkipComponentCleanup Parameter was used"
            } else {
                Dism /Image:"$MountWinRE" /Cleanup-Image /StartComponentCleanup /ResetBase /LogPath:"$CurrentLog" | Out-Null
            }
        }
    }

    if ($SkipUpdatesWinSE) {Return}
    #===================================================================================================
    #   Update WinSE
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinSE: (LCU) Latest Cumulative Update"
    
    if (($OSMajorVersion -eq 10) -and ($ReleaseId -ge 1903)) {Write-Warning 'Not adding LCU to WinSE to resolve Setup issues'; Return}
    foreach ($Update in $OSDUpdateLCU) {
        $UpdateLCU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {($_.FullName -like "*$($Update.Title)*") -and ($_.Name -match "$($Update.FileName)")}).FullName

        if ($null -eq $UpdateLCU) {Continue}
        if (!(Test-Path "$UpdateLCU")) {Write-Warning "Not Found: $UpdateSSU"; Continue}

        if (!($Force.IsPresent)) {
            $SessionsXmlInstall = "$MountWinSE\Windows\Servicing\Sessions\Sessions.xml"
            if (Test-Path $SessionsXmlInstall) {
                [xml]$XmlDocument = Get-Content -Path $SessionsXmlInstall
                if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.FileKBNumber)*" -and $_.targetState -eq 'Installed'}) {
                    Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                    Continue
                }
            }
        }

        Write-Host -ForegroundColor Cyan "INSTALLING        " -NoNewline
        Write-Host -ForegroundColor Gray "$($Update.Title) - $($Update.FileName)"

        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Update-CumulativePE-KB$($Update.KBNumber)-WinSE.log"
        Write-Verbose "CurrentLog: $CurrentLog"
        Try {Add-WindowsPackage -Path "$MountWinSE" -PackagePath "$UpdateLCU" -LogPath "$CurrentLog" | Out-Null}
        Catch {
            $ErrorMessage = $_.Exception.$ErrorMessage
            Write-Warning "$CurrentLog"
            Write-Host "$ErrorMessage"
            if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
        }
        if (!($OSVersion -like "6.1.7601.*")) {
            $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-DismCleanupImage-WinSE.log"
            Write-Verbose "CurrentLog: $CurrentLog"
            if ($SkipComponentCleanup) {
                Write-Warning "Skip: -SkipComponentCleanup Parameter was used"
            } else {
                Dism /Image:"$MountWinSE" /Cleanup-Image /StartComponentCleanup /ResetBase /LogPath:"$CurrentLog" | Out-Null
            }
        }
    }
}
