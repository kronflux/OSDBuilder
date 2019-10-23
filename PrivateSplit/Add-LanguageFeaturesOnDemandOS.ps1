function Add-LanguageFeaturesOnDemandOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ($OSMajorVersion -ne 10) {Return}
    if ([string]::IsNullOrWhiteSpace($LanguageFeatures)) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime; Write-Host -ForegroundColor Green "OS: Language Features On Demand"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($Update in $LanguageFeatures | Where-Object {$_ -notlike "*Speech*"}) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
            Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-LanguageFeaturesOnDemandOS.log" | Out-Null
        }
    }
    foreach ($Update in $LanguageFeatures | Where-Object {$_ -like "*TextToSpeech*"}) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
            Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-LanguageFeaturesOnDemandOS.log" | Out-Null
        }
    }
    foreach ($Update in $LanguageFeatures | Where-Object {$_ -like "*Speech*" -and $_ -notlike "*TextToSpeech*"}) {
        if (Test-Path "$OSDBuilderContent\$Update") {
            Write-Host "$OSDBuilderContent\$Update" -ForegroundColor DarkGray
            Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$Update" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-LanguageFeaturesOnDemandOS.log" | Out-Null
        }
    }
}
