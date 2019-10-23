function Get-FeatureUpdateDownloads {
    $FeatureUpdateDownloads = @()
    $FeatureUpdateDownloads = Get-OSDSUS FeatureUpdate
<#     $CatalogsXmls = @()
    $CatalogsXmls = Get-ChildItem "$($MyInvocation.MyCommand.Module.ModuleBase)\CatalogsESD\*" -Include *.xml
    foreach ($CatalogsXml in $CatalogsXmls) {
        $FeatureUpdateDownloads += Import-Clixml -Path "$($CatalogsXml.FullName)"
    } #>
    #===================================================================================================
    #   Get Downloadeds
    #===================================================================================================
    foreach ($Download in $FeatureUpdateDownloads) {
        $FullUpdatePath = "$OSDBuilderPath\Media\$($Download.FileName)"
        if (Test-Path $FullUpdatePath) {
            $Download.OSDStatus = "Downloaded"
        }
    }
    #===================================================================================================
    #   Return
    #===================================================================================================
    $FeatureUpdateDownloads = $FeatureUpdateDownloads | Select-Object -Property * | Sort-Object -Property CreationDate -Descending
    Return $FeatureUpdateDownloads
}
