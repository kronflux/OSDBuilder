function Update-SetupDUMEDIA {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Changelog
    #===================================================================================================
    #19.10.14 Resolved issue with color for Update FileName
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($SkipUpdates) {Return}
    if ($SkipSetupDU) {Return}
    if ($null -eq $OSDUpdateSetupDU) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "MEDIA: (SetupDU) Windows Setup Dynamic Update"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($Update in $OSDUpdateSetupDU) {
        $UpdateSetupDU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {($_.FullName -like "*$($Update.Title)*") -and ($_.Name -match "$($Update.FileName)")}).FullName
        if ($null -eq $UpdateSetupDU) {Continue}
        if (!(Test-Path "$UpdateSetupDU")) {Write-Warning "Not Found: $UpdateSetupDU"; Continue}

        Write-Host -ForegroundColor Cyan "INSTALLING        " -NoNewline
        Write-Host -ForegroundColor Gray "$($Update.Title) - $($Update.FileName)"

        expand.exe "$UpdateSetupDU" -F:*.* "$OS\Sources" | Out-Null
    }
}
