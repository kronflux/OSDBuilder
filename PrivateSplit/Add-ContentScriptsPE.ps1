function Add-ContentScriptsPE {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    #===================================================================================================
    #   TASK
    #===================================================================================================
    if ($WinPEScriptsPE -or $WinPEScriptsRE -or $WinPEScriptsSE) {
        Show-ActionTime; Write-Host -ForegroundColor Green "WinPE: Scripts TASK"
        foreach ($PSWimScript in $WinPEScriptsPE) {
            if (Test-Path "$OSDBuilderContent\$PSWimScript") {
                Write-Host "Source: $OSDBuilderContent\$PSWimScript" -ForegroundColor Cyan
                (Get-Content "$OSDBuilderContent\$PSWimScript").replace('winpe.wim.log', 'WinPE.log') | Set-Content "$OSDBuilderContent\$PSWimScript"
                Invoke-Expression "& '$OSDBuilderContent\$PSWimScript'"
            }
        }
        foreach ($PSWimScript in $WinPEScriptsRE) {
            if (Test-Path "$OSDBuilderContent\$PSWimScript") {
                Write-Host "Source: $OSDBuilderContent\$PSWimScript" -ForegroundColor Cyan
                (Get-Content "$OSDBuilderContent\$PSWimScript").replace('winre.wim.log', 'WinRE.log') | Set-Content "$OSDBuilderContent\$PSWimScript"
                Invoke-Expression "& '$OSDBuilderContent\$PSWimScript'"
            }
        }
        foreach ($PSWimScript in $WinPEScriptsSE) {
            if (Test-Path "$OSDBuilderContent\$PSWimScript") {
                Write-Host "Source: $OSDBuilderContent\$PSWimScript" -ForegroundColor Cyan
                (Get-Content "$OSDBuilderContent\$PSWimScript").replace('MountSetup', 'MountWinSE') | Set-Content "$OSDBuilderContent\$PSWimScript"
                (Get-Content "$OSDBuilderContent\$PSWimScript").replace('setup.wim.log', 'WinSE.log') | Set-Content "$OSDBuilderContent\$PSWimScript"
                Invoke-Expression "& '$OSDBuilderContent\$PSWimScript'"
            }
        }
    }
}
