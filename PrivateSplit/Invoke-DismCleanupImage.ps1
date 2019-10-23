function Invoke-DismCleanupImage {
    [CmdletBinding()]
    Param (
        [switch]$HideCleanupProgress
    )
    #19.10.14 Removed Out-Null.  Modified Warning Message
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($SkipUpdates) {Return}
    if ($SkipComponentCleanup) {Return}
    if ($OSVersion -like "6.1*") {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "OS: DISM Cleanup-Image StartComponentCleanup ResetBase"
    #===================================================================================================
    #   Abort Pending Operations
    #===================================================================================================
    if ($OSMajorVersion -eq 10) {
        if ($(Get-WindowsCapability -Path $MountDirectory | Where-Object {$_.state -eq "*pending*"})) {
            Write-Warning "Cannot run WindowsImage Cleanup on a WIM with Pending Installations"
            Return
        }
    }
    #===================================================================================================
    #   CurrentLog
    #===================================================================================================
    $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Invoke-DismCleanupImage.log"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if ($HideCleanupProgress.IsPresent) {
        Write-Warning "This process will take between 5 - 200 minutes to complete, depending on the number of Updates"
        Write-Warning "Check Task Manager DISM and DISMHOST processes for activity"
        Write-Host -ForegroundColor DarkGray "                  $CurrentLog"
        Dism /Image:"$MountDirectory" /Cleanup-Image /StartComponentCleanup /ResetBase /LogPath:"$CurrentLog" | Out-Null
    } else {
        Write-Verbose "$CurrentLog"
        Dism /Image:"$MountDirectory" /Cleanup-Image /StartComponentCleanup /ResetBase /LogPath:"$CurrentLog"
    }
    #===================================================================================================
}
