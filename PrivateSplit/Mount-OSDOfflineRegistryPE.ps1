function Mount-OSDOfflineRegistryPE {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$MountPath
    )
    if (($MountPath) -and (Test-Path "$MountPath" -ErrorAction SilentlyContinue)) {
        if (Test-Path "$MountPath\Windows\ServiceProfiles\LocalService\NTUser.dat") {
            Write-Verbose "Loading Offline Registry Hive System Profile" 
            Start-Process reg -ArgumentList "load HKLM\OfflineDefaultUser $MountPath\Windows\ServiceProfiles\LocalService\NTUser.dat" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue
        }
        if (Test-Path "$MountPath\Windows\System32\Config\DEFAULT") {
            Write-Verbose "Loading Offline Registry Hive DEFAULT" 
            Start-Process reg -ArgumentList "load HKLM\OfflineDefault $MountPath\Windows\System32\Config\DEFAULT" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue
        }
        if (Test-Path "$MountPath\Windows\System32\Config\SOFTWARE") {
            Write-Verbose "Loading Offline Registry Hive SOFTWARE" 
            Start-Process reg -ArgumentList "load HKLM\OfflineSoftware $MountPath\Windows\System32\Config\SOFTWARE" -Wait -WindowStyle Hidden -ErrorAction Stop
        }
        if (Test-Path "$MountPath\Windows\System32\Config\SYSTEM") {
            Write-Verbose "Loading Offline Registry Hive SYSTEM" 
            Start-Process reg -ArgumentList "load HKLM\OfflineSystem $MountPath\Windows\System32\Config\SYSTEM" -Wait -WindowStyle Hidden -ErrorAction Stop
        }
    }
}
