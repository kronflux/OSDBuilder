function Get-OSTemplateDrivers {
    [CmdletBinding()]
    Param ()

    $DriverTemplates = @()

    #Write-Host "$OSDBuilderTemplates\Drivers\AutoApply\Global" -ForegroundColor Gray
    [array]$DriverTemplates = Get-Item "$OSDBuilderTemplates\Drivers\AutoApply\Global"

    #Write-Host "$OSDBuilderTemplates\Drivers\AutoApply\Global $OSArchitecture" -ForegroundColor Gray
    [array]$DriverTemplates += Get-Item "$OSDBuilderTemplates\Drivers\AutoApply\Global $OSArchitecture"

    #Write-Host "$OSDBuilderTemplates\Drivers\AutoApply\$UpdateOS" -ForegroundColor Gray
    [array]$DriverTemplates += Get-Item "$OSDBuilderTemplates\Drivers\AutoApply\$UpdateOS"

    if ($OSInstallationType -notlike "*Server*") {
        #Write-Host "$OSDBuilderTemplates\Drivers\AutoApply\$UpdateOS $OSArchitecture" -ForegroundColor Gray
        [array]$DriverTemplates += Get-Item "$OSDBuilderTemplates\Drivers\AutoApply\$UpdateOS $OSArchitecture"
    }
    if ($OSInstallationType -notlike "*Server*" -and $OSMajorVersion -eq 10) {
        #Write-Host "$OSDBuilderTemplates\Drivers\AutoApply\$UpdateOS $OSArchitecture $ReleaseId" -ForegroundColor Gray
        [array]$DriverTemplates += Get-Item "$OSDBuilderTemplates\Drivers\AutoApply\$UpdateOS $OSArchitecture $ReleaseId"
    }
    Return $DriverTemplates
}
