function Import-AutoExtraFilesPE {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ($WinPEAutoExtraFiles -ne $true) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime; Write-Host -ForegroundColor Green "WinPE: Import AutoExtraFiles"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    Write-Host "Source: $WinPE\AutoExtraFiles" -ForegroundColor DarkGray
    $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Import-AutoExtraFilesPE.log"

    robocopy "$WinPE\AutoExtraFiles" "$MountWinPE" *.* /e /ndl /xf bcp47*.dll /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
    robocopy "$WinPE\AutoExtraFiles" "$MountWinRE" *.* /e /ndl /xf bcp47*.dll /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
    robocopy "$WinPE\AutoExtraFiles" "$MountWinSE" *.* /e /ndl /xf bcp47*.dll /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
    #===================================================================================================
}
