function Remove-WindowsPackageOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ([string]::IsNullOrWhiteSpace($RemovePackage)) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "OS: Remove Windows Packages"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($PackageName in $RemovePackage) {
        Write-Host $PackageName -ForegroundColor DarkGray
        Try {
            Remove-WindowsPackage -Path "$MountDirectory" -PackageName $PackageName -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Remove-WindowsPackage.log" | Out-Null
        }
        Catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "$ErrorMessage"
        }
    }
}
