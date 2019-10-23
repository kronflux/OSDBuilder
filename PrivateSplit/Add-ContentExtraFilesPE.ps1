function Add-ContentExtraFilesPE {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   ABORT
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    #===================================================================================================
    #   TASK
    #===================================================================================================
    if ($WinPEExtraFilesPE -or $WinPEExtraFilesRE -or $WinPEExtraFilesSE) {
        Show-ActionTime; Write-Host -ForegroundColor Green "WinPE: Extra Files TASK"
        foreach ($ExtraFile in $WinPEExtraFilesPE) {
            Write-Host "Source: $OSDBuilderContent\$ExtraFile" -ForegroundColor DarkGray
            $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentExtraFilesPE.log"
            Write-Verbose "CurrentLog: $CurrentLog"
            robocopy "$OSDBuilderContent\$ExtraFile" "$MountWinPE" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
        }
        foreach ($ExtraFile in $WinPEExtraFilesRE) {
            Write-Host "Source: $OSDBuilderContent\$ExtraFile" -ForegroundColor DarkGray
            $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentExtraFilesPE.log"
            Write-Verbose "CurrentLog: $CurrentLog"
            robocopy "$OSDBuilderContent\$ExtraFile" "$MountWinRE" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
        }
        foreach ($ExtraFile in $WinPEExtraFilesSE) {
            Write-Host "Source: $OSDBuilderContent\$ExtraFile" -ForegroundColor DarkGray
            $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentExtraFilesPE.log"
            Write-Verbose "CurrentLog: $CurrentLog"
            robocopy "$OSDBuilderContent\$ExtraFile" "$MountWinSE" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
        }
    } else {
        Return
    }
}
