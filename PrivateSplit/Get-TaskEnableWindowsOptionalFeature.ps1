function Get-TaskEnableWindowsOptionalFeature {
    #===================================================================================================
    #   EnableWindowsOptionalFeature
    #===================================================================================================
    [CmdletBinding()]
    Param ()
    if (Test-Path "$($OSMedia.FullName)\info\xml\Get-WindowsOptionalFeature.xml") {
        $EnableWindowsOptionalFeature = Import-CliXml "$($OSMedia.FullName)\info\xml\Get-WindowsOptionalFeature.xml"
    }
    $EnableWindowsOptionalFeature = $EnableWindowsOptionalFeature | Select-Object -Property FeatureName, State | Sort-Object -Property FeatureName | Where-Object {$_.State -eq 0}
    $EnableWindowsOptionalFeature = $EnableWindowsOptionalFeature | Select-Object -Property FeatureName
    if ($ExistingTask.EnableWindowsOptionalFeature) {
        foreach ($Item in $ExistingTask.EnableWindowsOptionalFeature) {
            $EnableWindowsOptionalFeature = $EnableWindowsOptionalFeature | Where-Object {$_.FeatureName -ne $Item}
        }
    }

    $EnableWindowsOptionalFeature = $EnableWindowsOptionalFeature | Out-GridView -PassThru -Title "Enable-WindowsOptionalFeature: Select Windows Optional Features to ENABLE and press OK (Esc or Cancel to Skip)"
    foreach ($Item in $EnableWindowsOptionalFeature) {Write-Host "$($Item.FeatureName)" -ForegroundColor White}
    Return $EnableWindowsOptionalFeature
}
