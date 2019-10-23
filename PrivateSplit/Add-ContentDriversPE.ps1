function Add-ContentDriversPE {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    #===================================================================================================
    #   Task
    #===================================================================================================
    if ([string]::IsNullOrWhiteSpace($WinPEDrivers)) {Return}
    Show-ActionTime; Write-Host -ForegroundColor Green "WinPE: Add-ContentDriversPE"
    foreach ($WinPEDriver in $WinPEDrivers) {
        Write-Host "$OSDBuilderContent\$WinPEDriver" -ForegroundColor DarkGray
        
        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentDriversPE-Task.log"
        Write-Verbose "CurrentLog: $CurrentLog"

        if ($OSMajorVersion -eq 6) {
            dism /Image:"$MountWinPE" /Add-Driver /Driver:"$OSDBuilderContent\$WinPEDriver" /Recurse /ForceUnsigned /LogPath:"$CurrentLog"
            dism /Image:"$MountWinRE" /Add-Driver /Driver:"$OSDBuilderContent\$WinPEDriver" /Recurse /ForceUnsigned /LogPath:"$CurrentLog"
            dism /Image:"$MountWinSE" /Add-Driver /Driver:"$OSDBuilderContent\$WinPEDriver" /Recurse /ForceUnsigned /LogPath:"$CurrentLog"
        } else {
            Add-WindowsDriver -Path "$MountWinPE" -Driver "$OSDBuilderContent\$WinPEDriver" -Recurse -ForceUnsigned -LogPath "$CurrentLog" | Out-Null
            Add-WindowsDriver -Path "$MountWinRE" -Driver "$OSDBuilderContent\$WinPEDriver" -Recurse -ForceUnsigned -LogPath "$CurrentLog" | Out-Null
            Add-WindowsDriver -Path "$MountWinSE" -Driver "$OSDBuilderContent\$WinPEDriver" -Recurse -ForceUnsigned -LogPath "$CurrentLog" | Out-Null
        }
    }
}
