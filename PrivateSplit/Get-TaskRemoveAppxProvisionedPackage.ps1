function Get-TaskRemoveAppxProvisionedPackage {
    #===================================================================================================
    #   RemoveAppx
    #===================================================================================================
    [CmdletBinding()]
    Param ()
    if ($($OSMedia.InstallationType) -eq 'Client') {
        if (Test-Path "$($OSMedia.FullName)\info\xml\Get-AppxProvisionedPackage.xml") {
            $RemoveAppxProvisionedPackage = Import-CliXml "$($OSMedia.FullName)\info\xml\Get-AppxProvisionedPackage.xml"
            $RemoveAppxProvisionedPackage = $RemoveAppxProvisionedPackage | Select-Object -Property DisplayName, PackageName
            if ($ExistingTask.RemoveAppxProvisionedPackage) {
                foreach ($Item in $ExistingTask.RemoveAppxProvisionedPackage) {
                    $RemoveAppxProvisionedPackage = $RemoveAppxProvisionedPackage | Where-Object {$_.PackageName -ne $Item}
                }
            }
            $RemoveAppxProvisionedPackage = $RemoveAppxProvisionedPackage | Out-GridView -Title "Remove-AppxProvisionedPackage: Select Packages to REMOVE and press OK (Esc or Cancel to Skip)" -PassThru
        }
        foreach ($Item in $RemoveAppxProvisionedPackage) {Write-Host "$($Item.PackageName)" -ForegroundColor White}
        Return $RemoveAppxProvisionedPackage
    } else {Write-Warning "Remove-AppxProvisionedPackage: Unsupported"}
}
