function Update-OptionalOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ($SkipUpdates) {Return}
    if ($SkipUpdatesOS) {Return}
    if ($OSMajorVersion -ne 10) {Return}
    if ($null -eq $OSDUpdateOptional) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "OS: Optional Updates"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($Update in $OSDUpdateOptional) {
        $UpdateOptional = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {($_.FullName -like "*$($Update.Title)*") -and ($_.Name -match "$($Update.FileName)")}).FullName
        if ($null -eq $UpdateOptional) {Continue}
        if (!(Test-Path "$UpdateOptional")) {Write-Warning "Not Found: $UpdateOptional"; Continue}

        if (Get-WindowsPackage -Path "$MountDirectory" | Where-Object {$_.PackageName -match "$($Update.KBNumber)"}) {
            Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
        } else {
            Write-Host -ForegroundColor Cyan "INSTALLING        " -NoNewline
            Write-Host -ForegroundColor Gray "$($Update.Title) - $($Update.FileName)"
            $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Update-OptionalOS-KB$($Update.FileKBNumber).log"
            Write-Verbose "CurrentLog: $CurrentLog"
            Try {Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$UpdateOptional" -LogPath "$CurrentLog" | Out-Null}
            Catch {
                $ErrorMessage = $_.Exception.$ErrorMessage
                Write-Warning "$CurrentLog"
                #Write-Host "$ErrorMessage"
                #if ($ErrorMessage -match '800f081e') {Write-Warning "Update not applicable to this Operating System"}
            }
        }
    }
}
