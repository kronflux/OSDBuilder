function Get-OSTemplateRegistryXml {
    [CmdletBinding()]
    Param ()

    $RegistryTemplatesXml = @()

    #Write-Host "$OSDBuilderTemplates\Registry\AutoApply\Global" -ForegroundColor DarkGray
    [array]$RegistryTemplatesXml = Get-ChildItem "$OSDBuilderTemplates\Registry\AutoApply\Global\*" *.xml -Recurse

    #Write-Host "$OSDBuilderTemplates\Registry\AutoApply\Global $OSArchitecture" -ForegroundColor DarkGray
    [array]$RegistryTemplatesXml += Get-ChildItem "$OSDBuilderTemplates\Registry\AutoApply\Global $OSArchitecture\*" *.xml -Recurse

    #Write-Host "$OSDBuilderTemplates\Registry\AutoApply\$UpdateOS" -ForegroundColor DarkGray
    [array]$RegistryTemplatesXml += Get-ChildItem "$OSDBuilderTemplates\Registry\AutoApply\$UpdateOS\*" *.xml -Recurse

    if ($OSInstallationType -notlike "*Server*") {
        #Write-Host "$OSDBuilderTemplates\Registry\AutoApply\$UpdateOS $OSArchitecture" -ForegroundColor DarkGray
        [array]$RegistryTemplatesXml += Get-ChildItem "$OSDBuilderTemplates\Registry\AutoApply\$UpdateOS $OSArchitecture\*" *.xml -Recurse
    }
    if ($OSInstallationType -notlike "*Server*" -and $OSMajorVersion -eq 10) {
        #Write-Host "$OSDBuilderTemplates\Registry\AutoApply\$UpdateOS $OSArchitecture $ReleaseId" -ForegroundColor DarkGray
        [array]$RegistryTemplatesXml += Get-ChildItem "$OSDBuilderTemplates\Registry\AutoApply\$UpdateOS $OSArchitecture $ReleaseId\*" *.xml -Recurse
    }
    Return $RegistryTemplatesXml
}
