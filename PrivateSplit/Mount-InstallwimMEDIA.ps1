function Mount-InstallwimMEDIA {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "Mount Install.wim: $MountDirectory"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if (!(Test-Path "$MountDirectory")) {New-Item "$MountDirectory" -ItemType Directory -Force | Out-Null}

    if ($InstallWimType -eq "esd") {
        Write-Host -ForegroundColor Gray "                  Image: Mount $TempESD (Index 1) to $MountDirectory"
        Mount-WindowsImage -ImagePath "$TempESD" -Index '1' -Path "$MountDirectory" -ReadOnly | Out-Null
    } else {
        Write-Host -ForegroundColor Gray "                  Image: Mount $OSImagePath (Index $OSImageIndex) to $MountDirectory"
        Mount-WindowsImage -ImagePath "$OSImagePath" -Index $OSImageIndex -Path "$MountDirectory" -ReadOnly | Out-Null
    }
}
