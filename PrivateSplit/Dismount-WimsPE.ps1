function Dismount-WimsPE {
    [CmdletBinding()]
    Param (
        [string]$OSMediaPath
    )
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: Dismount-WimsPE"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    Start-Sleep -Seconds 10
    
    Write-Verbose "$MountWinPE"
    $CurrentLog = "$OSMediaPath\WinPE\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dismount-WimsPE-WinPE.log"
    Write-Verbose "CurrentLog: $CurrentLog"
    try {
        Dismount-WindowsImage -Path "$MountWinPE" -Save -LogPath "$CurrentLog" -ErrorAction SilentlyContinue | Out-Null
    }
    catch {
        Write-Warning "Could not dismount WinPE ... Waiting 30 seconds ..."
        Start-Sleep -Seconds 30
        Dismount-WindowsImage -Path "$MountWinPE" -Save -LogPath "$CurrentLog" | Out-Null
    }
    
    Write-Verbose "$MountWinRE"
    $CurrentLog = "$OSMediaPath\WinPE\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dismount-WimsPE-WinRE.log"
    Write-Verbose "CurrentLog: $CurrentLog"
    try {
        Dismount-WindowsImage -Path "$MountWinRE" -Save -LogPath "$CurrentLog" -ErrorAction SilentlyContinue | Out-Null
    }
    catch {
        Write-Warning "Could not dismount WinRE ... Waiting 30 seconds ..."
        Start-Sleep -Seconds 30
        Dismount-WindowsImage -Path "$MountWinRE" -Save -LogPath "$CurrentLog" | Out-Null
    }
    
    Write-Verbose "$MountWinSE"
    $CurrentLog = "$OSMediaPath\WinPE\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Dismount-WimsPE-WinSE.log"
    Write-Verbose "CurrentLog: $CurrentLog"
    try {
        Dismount-WindowsImage -Path "$MountWinSE" -Save -LogPath "$CurrentLog" -ErrorAction SilentlyContinue | Out-Null
    }
    catch {
        Write-Warning "Could not dismount WinSE ... Waiting 30 seconds ..."
        Start-Sleep -Seconds 30
        Dismount-WindowsImage -Path "$MountWinSE" -Save -LogPath "$CurrentLog" | Out-Null
    }
    #===================================================================================================
}
