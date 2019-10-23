function Remove-AppxProvisionedPackageOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ($OSMajorVersion -ne 10) {Return}
    if ([string]::IsNullOrWhiteSpace($RemoveAppx)) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "OS: Remove Appx Packages"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($item in $RemoveAppx) {
        Write-Host $item -ForegroundColor DarkGray
        Try {
            Remove-AppxProvisionedPackage -Path "$MountDirectory" -PackageName $item -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Remove-AppxProvisionedPackage.log" | Out-Null
        }
        Catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "$ErrorMessage"
        }
    }
}
