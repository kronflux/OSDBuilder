function Copy-MediaOperatingSystem {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "MEDIA: Copy Operating System to $WorkingPath"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    Copy-Item -Path "$OSMediaPath\*" -Destination "$WorkingPath" -Exclude ('*.wim','*.iso','*.vhd','*.vhx') -Recurse -Force | Out-Null
    if (Test-Path "$WorkingPath\ISO") {Remove-Item -Path "$WorkingPath\ISO" -Force -Recurse | Out-Null}
    if (Test-Path "$WorkingPath\VHD") {Remove-Item -Path "$WorkingPath\VHD" -Force -Recurse | Out-Null}
    Copy-Item -Path "$OSMediaPath\OS\sources\install.wim" -Destination "$WimTemp\install.wim" -Force | Out-Null
    Copy-Item -Path "$OSMediaPath\WinPE\*.wim" -Destination "$WimTemp" -Exclude boot.wim -Force | Out-Null
}
