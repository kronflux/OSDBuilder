function Add-ContentADKWinPE {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ([string]::IsNullOrWhiteSpace($WinPEADKPE)) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: WinPE.wim ADK Optional Components"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    $WinPEADKPE = $WinPEADKPE | Sort-Object Length

    foreach ($PackagePath in $WinPEADKPE) {
        if ($PackagePath -like "*WinPE-NetFx*") {
            $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentADKWinPE.log"
            Write-Verbose "CurrentLog: $CurrentLog"

            Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor DarkGray
            Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinPE" -LogPath "$CurrentLog" | Out-Null
        }
    }

    $WinPEADKPE = $WinPEADKPE | Where-Object {$_.Name -notlike "*WinPE-NetFx*"}
    foreach ($PackagePath in $WinPEADKPE) {
        if ($PackagePath -like "*WinPE-PowerShell*") {
            $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentADKWinPE.log"
            Write-Verbose "CurrentLog: $CurrentLog"

            Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor DarkGray
            Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinPE" -LogPath "$CurrentLog" | Out-Null
        }
    }

    $WinPEADKPE = $WinPEADKPE | Where-Object {$_.Name -notlike "*WinPE-PowerShell*"}
    foreach ($PackagePath in $WinPEADKPE) {
        Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor DarkGray
        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentADKWinPE.log"
        Write-Verbose "CurrentLog: $CurrentLog"
        if ($OSMajorVersion -eq 6) {
            dism /Image:"$MountWinPE" /Add-Package /PackagePath:"$OSDBuilderContent\$PackagePath" /LogPath:"$CurrentLog"
        } else {
            Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinPE" -LogPath "$CurrentLog" | Out-Null
        }
    }
}
