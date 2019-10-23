function Add-WindowsPackageOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    #===================================================================================================
    #   Task
    #===================================================================================================
    if ([string]::IsNullOrWhiteSpace($Packages)) {Return}
    Show-ActionTime; Write-Host -ForegroundColor Green "OS: Add Packages"
    foreach ($PackagePath in $Packages) {
        Write-Host "$OSDBuilderContent\$PackagePath" -ForegroundColor DarkGray
        Try {
            Add-WindowsPackage -PackagePath "$OSDBuilderContent\$PackagePath" -Path "$MountDirectory" -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-WindowsPackageOS.log" | Out-Null
        }
        Catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "$ErrorMessage"
        }
    }
}
