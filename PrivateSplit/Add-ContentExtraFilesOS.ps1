function Add-ContentExtraFilesOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   ABORT
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    #===================================================================================================
    #   TASK
    #===================================================================================================
    if ($ExtraFiles) {
        Show-ActionTime; Write-Host -ForegroundColor Green "OS: Extra Files TASK"
        foreach ($ExtraFile in $ExtraFiles) {
        
            $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentExtraFilesOS-Task.log"
            Write-Verbose "CurrentLog: $CurrentLog"

            Write-Host "$OSDBuilderContent\$ExtraFile" -ForegroundColor DarkGray
            robocopy "$OSDBuilderContent\$ExtraFile" "$MountDirectory" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
        }
    }
    #===================================================================================================
    #   TEMPLATE
    #===================================================================================================
    if ($ExtraFilesTemplates) {
        Show-ActionTime; Write-Host -ForegroundColor Green "OS: Extra Files TEMPLATE"
        foreach ($ExtraFile in $ExtraFilesTemplates) {
        
            $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentExtraFilesOS-Template.log"
            Write-Verbose "CurrentLog: $CurrentLog"

            Write-Host "$($ExtraFile.FullName)" -ForegroundColor DarkGray
            robocopy "$($ExtraFile.FullName)" "$MountDirectory" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
        }
    }
}
