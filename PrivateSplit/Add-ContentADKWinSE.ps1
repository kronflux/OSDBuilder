function Add-ContentADKWinSE {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ([string]::IsNullOrWhiteSpace($WinPEADKSE)) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: WinSE.wim ADK Optional Components"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    $WinPEADKSE = $WinPEADKSE | Sort-Object Length
    foreach ($PackagePath in $WinPEADKSE) {
        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentADKWinSE.log"
        Write-Verbose "CurrentLog: $CurrentLog"

        if ($PackagePath -like "*WinPE-NetFx*") {
            Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor DarkGray
            Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinSE" -LogPath "$CurrentLog" | Out-Null
        }
    }
    $WinPEADKSE = $WinPEADKSE | Where-Object {$_.Name -notlike "*WinPE-NetFx*"}
    foreach ($PackagePath in $WinPEADKSE) {
        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentADKWinSE.log"
        Write-Verbose "CurrentLog: $CurrentLog"

        if ($PackagePath -like "*WinPE-PowerShell*") {
            Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor DarkGray
            Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinSE" -LogPath "$CurrentLog" | Out-Null
        }
    }
    $WinPEADKSE = $WinPEADKSE | Where-Object {$_.Name -notlike "*WinPE-PowerShell*"}
    foreach ($PackagePath in $WinPEADKSE) {
        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentADKWinSE.log"
        Write-Verbose "CurrentLog: $CurrentLog"

        Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor DarkGray
        if ($OSMajorVersion -eq 6) {
            dism /Image:"$MountWinSE" /Add-Package /PackagePath:"$OSDBuilderContent\$PackagePath" /LogPath:"$CurrentLog.log"
        } else {
            Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinSE" -LogPath "$CurrentLog" | Out-Null
        }
    }
}
