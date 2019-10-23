function Get-OSTemplateExtraFiles {
    [CmdletBinding()]
    Param ()

    $ExtraFilesTemplates = @()

    #Write-Host "$OSDBuilderTemplates\ExtraFiles\AutoApply\Global" -ForegroundColor DarkGray
    [array]$ExtraFilesTemplates = Get-ChildItem "$OSDBuilderTemplates\ExtraFiles\AutoApply\Global" | Where-Object {$_.PSIsContainer -eq $true} 

    #Write-Host "$OSDBuilderTemplates\ExtraFiles\AutoApply\Global $OSArchitecture" -ForegroundColor DarkGray
    [array]$ExtraFilesTemplates += Get-ChildItem "$OSDBuilderTemplates\ExtraFiles\AutoApply\Global $OSArchitecture" | Where-Object {$_.PSIsContainer -eq $true} 

    #Write-Host "$OSDBuilderTemplates\ExtraFiles\AutoApply\$UpdateOS" -ForegroundColor DarkGray
    [array]$ExtraFilesTemplates += Get-ChildItem "$OSDBuilderTemplates\ExtraFiles\AutoApply\$UpdateOS" | Where-Object {$_.PSIsContainer -eq $true} 

    if ($OSInstallationType -notlike "*Server*") {
        #Write-Host "$OSDBuilderTemplates\ExtraFiles\AutoApply\$UpdateOS $OSArchitecture" -ForegroundColor DarkGray
        [array]$ExtraFilesTemplates += Get-ChildItem "$OSDBuilderTemplates\ExtraFiles\AutoApply\$UpdateOS $OSArchitecture" | Where-Object {$_.PSIsContainer -eq $true} 
    }
    if ($OSInstallationType -notlike "*Server*" -and $OSMajorVersion -eq 10) {
        #Write-Host "$OSDBuilderTemplates\ExtraFiles\AutoApply\$UpdateOS $OSArchitecture $ReleaseId" -ForegroundColor DarkGray
        [array]$ExtraFilesTemplates += Get-ChildItem "$OSDBuilderTemplates\ExtraFiles\AutoApply\$UpdateOS $OSArchitecture $ReleaseId" | Where-Object {$_.PSIsContainer -eq $true} 
    }
    Return $ExtraFilesTemplates
}
