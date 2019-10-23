function Update-SourcesPE {
    [CmdletBinding()]
    Param (
        [string]$OSMediaPath
    )
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($SkipUpdates) {Return}
    if ($SkipUpdatesPE) {Return}
    if ($SkipUpdatesOS) {Return}
    if ($ReleaseId -ge 1903) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime; Write-Host -ForegroundColor Green "MEDIA: Update Media Sources with WinSE.wim"
    #===================================================================================================
    #   Warning
    #===================================================================================================
    if ($OSBuild -ge 18362) {
        Write-Warning "Skipping Update for this version of Windows"
        Return
    }
    if ($ReleaseId -ge 1903) {
        Write-Warning "This step is currently disabled for Windows 10 1903"
        Write-Warning "If this is the first time you are seeing this warning,"
        Write-Warning "you should Update-OSMedia from Windows 10 1903 18362.30"
        Return
    }
    #===================================================================================================
    #   Execute
    #===================================================================================================
    robocopy "$MountWinSE\sources" "$OSMediaPath\OS\sources" setup.exe /ndl /xo /xx /xl /b /np /ts /tee /r:0 /w:0 /Log+:"$OSMediaPath\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Robocopy-WinSE-MediaSources.log" | Out-Null
    robocopy "$MountWinSE\sources" "$OSMediaPath\OS\sources" setuphost.exe /ndl /xo /xx /xl /b /np /ts /tee /r:0 /w:0 /Log+:"$OSMediaPath\info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Robocopy-WinSE-MediaSources.log" | Out-Null
}
