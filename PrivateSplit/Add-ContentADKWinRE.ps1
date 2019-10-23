function Add-ContentADKWinRE {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ([string]::IsNullOrWhiteSpace($WinPEADKRE)) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: WinRE.wim ADK Optional Components"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    $WinPEADKRE = $WinPEADKRE | Sort-Object Length
    foreach ($PackagePath in $WinPEADKRE) {
        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentADKWinRE.log"
        Write-Verbose "CurrentLog: $CurrentLog"

        if ($PackagePath -like "*WinPE-NetFx*") {
            Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor DarkGray
            Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinRE" -LogPath "$CurrentLog" | Out-Null
        }
    }

    $WinPEADKRE = $WinPEADKRE | Where-Object {$_.Name -notlike "*WinPE-NetFx*"}
    foreach ($PackagePath in $WinPEADKRE) {
        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentADKWinRE.log"
        Write-Verbose "CurrentLog: $CurrentLog"

        if ($PackagePath -like "*WinPE-PowerShell*") {
            Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor DarkGray
            Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinRE" -LogPath "$CurrentLog" | Out-Null
        }
    }
    $WinPEADKRE = $WinPEADKRE | Where-Object {$_.Name -notlike "*WinPE-PowerShell*"}
    foreach ($PackagePath in $WinPEADKRE) {
        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentADKWinRE.log"
        Write-Verbose "CurrentLog: $CurrentLog"

        Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor DarkGray
        if ($OSMajorVersion -eq 6) {
            dism /Image:"$MountWinRE" /Add-Package /PackagePath:"$OSDBuilderContent\$PackagePath" /LogPath:"$CurrentLog"
        } else {
            Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountWinRE" -LogPath "$CurrentLog" | Out-Null
        }
    }
}
