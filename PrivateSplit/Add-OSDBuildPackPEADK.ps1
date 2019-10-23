function Add-OSDBuildPackPEADK {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$BuildPackContent
    )
    #======================================================================================
    #   Test
    #======================================================================================
    if (!(Test-Path "$BuildPackContent\*")) {
        Write-Verbose "Add-OSDBuildPackPEADK: Unable to locate content in $BuildPackContent"
        Return
    } else {
        Write-Host "$BuildPackContent" -ForegroundColor Cyan
    }
    #======================================================================================
    #   Import
    #======================================================================================
    $ADKFiles = Get-ChildItem "$BuildPackContent\*" -Include *.cab -File | Sort-Object Length -Descending | Select-Object Name, FullName
    $ADKFilesSub = Get-ChildItem "$BuildPackContent\*\*" -Include *.cab -File -Recurse | Sort-Object Length -Descending | Select-Object Name, FullName

    foreach ($ADKFile in $ADKFiles) {
        $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-BuildPackPEADK-$($ADKFile.Name).log"
        Write-Verbose "CurrentLog: $CurrentLog"
        
        Write-Host "$($ADKFile.FullName)" -ForegroundColor DarkGray
        Add-WindowsPackage -PackagePath "$($ADKFile.FullName)" -Path "$MountWinPE" -LogPath "$CurrentLog" | Out-Null
        Add-WindowsPackage -PackagePath "$($ADKFile.FullName)" -Path "$MountWinRE" -LogPath "$CurrentLog" | Out-Null
        Add-WindowsPackage -PackagePath "$($ADKFile.FullName)" -Path "$MountWinSE" -LogPath "$CurrentLog" | Out-Null
    }

    foreach ($ADKFile in $ADKFilesSub) {
        $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-BuildPackPEADK-$($ADKFile.Name).log"
        Write-Verbose "CurrentLog: $CurrentLog"

        Write-Host "$($ADKFile.FullName)" -ForegroundColor DarkGray
        Add-WindowsPackage -PackagePath "$($ADKFile.FullName)" -Path "$MountWinPE" -LogPath "$CurrentLog" | Out-Null
        Add-WindowsPackage -PackagePath "$($ADKFile.FullName)" -Path "$MountWinRE" -LogPath "$CurrentLog" | Out-Null
        Add-WindowsPackage -PackagePath "$($ADKFile.FullName)" -Path "$MountWinSE" -LogPath "$CurrentLog" | Out-Null
    }
}
