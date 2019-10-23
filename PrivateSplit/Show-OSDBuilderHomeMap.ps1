function Show-OSDBuilderHomeMap {
    [CmdletBinding()]
    Param ()
    Write-Host ""
    
    if (Test-Path "$OSDBuilderPath")            {Write-Host "OSDBuilder Home:                                    $OSDBuilderPath" -ForegroundColor White}
    else                                        {Write-Host "OSDBuilder Home:                                    $OSDBuilderPath (does not exist)" -ForegroundColor White}
    if ($BuildPacksEnabled -eq $true) {
        if (Test-Path "$OSDBuilderBuildPacks")  {Write-Host "BuildPacks:                                         $OSDBuilderBuildPacks" -ForegroundColor Cyan}
        else                                    {Write-Host "BuildPacks:                                         $OSDBuilderBuildPacks (does not exist)" -ForegroundColor Gray}
    }

<#     if (Test-Path "$OSDBuilderOSImport")            {Write-Host "OSImport:          $OSDBuilderOSImport" -ForegroundColor Gray}
        else                                        {Write-Host "OSImport:          $OSDBuilderOSImport (does not exist)" -ForegroundColor Gray}
    if (Test-Path "$OSDBuilderOSMedia")             {Write-Host "OSMedia:           $OSDBuilderOSMedia" -ForegroundColor Gray}
        else                                        {Write-Host "OSMedia:           $OSDBuilderOSMedia (does not exist)" -ForegroundColor Gray}
    if (Test-Path "$OSDBuilderOSBuilds")            {Write-Host "OSBuilds:          $OSDBuilderOSBuilds" -ForegroundColor Gray}
        else                                        {Write-Host "OSBuilds:          $OSDBuilderOSBuilds (does not exist)" -ForegroundColor Gray}
    if (Test-Path "$OSDBuilderPEBuilds")            {Write-Host "PEBuilds:          $OSDBuilderPEBuilds" -ForegroundColor Gray}
        else                                        {Write-Host "PEBuilds:          $OSDBuilderPEBuilds (does not exist)" -ForegroundColor Gray}
    if (Test-Path "$OSDBuilderTasks")               {Write-Host "Tasks:             $OSDBuilderTasks" -ForegroundColor Gray}
        else                                        {Write-Host "Tasks:             $OSDBuilderTasks (does not exist)" -ForegroundColor Gray}
    if (Test-Path "$OSDBuilderTemplates")           {Write-Host "Templates:         $OSDBuilderTemplates" -ForegroundColor Gray}
        else                                        {Write-Host "Templates:         $OSDBuilderTemplates (does not exist)" -ForegroundColor Gray}
    if (Test-Path "$OSDBuilderContent")             {Write-Host "Content:           $OSDBuilderContent" -ForegroundColor Gray}
        else                                        {Write-Host "Content:           $OSDBuilderContent (does not exist)" -ForegroundColor Gray} #>

}
