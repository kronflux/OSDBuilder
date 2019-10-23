function Add-OSDBuildPackPERegistry {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$BuildPackContent,
        [switch]$ShowRegContent
    )
    #======================================================================================
    #   Test-OSDBuildPackPERegistry
    #======================================================================================
    if (!(Test-Path "$BuildPackContent\*")) {
        Write-Verbose "Add-OSDBuildPackPERegistry: Unable to locate content in $BuildPackContent"
        Return
    } else {
        Write-Host "$BuildPackContent" -ForegroundColor Cyan
    }

    #======================================================================================
    #   Mount-OfflineRegistryHives
    #======================================================================================
    if (($MountWinPE) -and (Test-Path "$MountWinPE" -ErrorAction SilentlyContinue)) {
        Mount-OSDOfflineRegistryPE -MountPath $MountWinPE
    } else {Return}
    $OSDBuildPackTemp = "$env:TEMP\$(Get-Random)"
    if (!(Test-Path $OSDBuildPackTemp)) {New-Item -Path "$OSDBuildPackTemp" -ItemType Directory -Force | Out-Null}

    #======================================================================================
    #   Get-RegFiles
    #======================================================================================
    [array]$BuildPackContentFiles = @()
    [array]$BuildPackContentFiles = Get-ChildItem "$BuildPackContent" *.reg -Recurse | Select-Object -Property Name, BaseName, Extension, Directory, FullName

    #======================================================================================
    #	Add-OSDBuildPackPERegistryFiles
    #======================================================================================
    foreach ($OSDRegistryRegFile in $BuildPackContentFiles) {
        $OSDRegistryImportFile = $OSDRegistryRegFile.FullName

        if ($MountWinPE) {
            $RegFileContent = Get-Content -Path $OSDRegistryImportFile
            $OSDRegistryImportFile = "$OSDBuildPackTemp\$($OSDRegistryRegFile.BaseName).reg"

            $RegFileContent = $RegFileContent -replace 'HKEY_CURRENT_USER','HKEY_LOCAL_MACHINE\OfflineDefaultUser'
            $RegFileContent = $RegFileContent -replace 'HKEY_LOCAL_MACHINE\\SOFTWARE','HKEY_LOCAL_MACHINE\OfflineSoftware'
            $RegFileContent = $RegFileContent -replace 'HKEY_LOCAL_MACHINE\\SYSTEM','HKEY_LOCAL_MACHINE\OfflineSystem'
            $RegFileContent = $RegFileContent -replace 'HKEY_USERS\\.DEFAULT','HKEY_LOCAL_MACHINE\OfflineDefault'
            $RegFileContent | Set-Content -Path $OSDRegistryImportFile -Force
        }

        Write-Host "$OSDRegistryImportFile"  -ForegroundColor DarkGray
        if ($ShowRegContent.IsPresent){
            $OSDBuildPackRegFileContent = @()
            $OSDBuildPackRegFileContent = Get-Content -Path $OSDRegistryImportFile
            foreach ($Line in $OSDBuildPackRegFileContent) {
                Write-Host "$Line" -ForegroundColor Gray
            }
        }
        Start-Process reg -ArgumentList ('import',"`"$OSDRegistryImportFile`"") -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue
    }
    
    #======================================================================================
    #	Remove-OSDBuildPackTemp
    #======================================================================================
    if ($MountWinPE) {
        if (Test-Path $OSDBuildPackTemp) {Remove-Item -Path "$OSDBuildPackTemp" -Recurse -Force | Out-Null}
    }
    #======================================================================================
    #	Dismount-RegistryHives
    #======================================================================================
    Dismount-OSDOfflineRegistry -MountPath $MountWinPE
    #======================================================================================
    #   Mount-OfflineRegistryHives
    #======================================================================================
    if (($MountWinRE) -and (Test-Path "$MountWinRE" -ErrorAction SilentlyContinue)) {
        Mount-OSDOfflineRegistryPE -MountPath $MountWinRE
    } else {Return}
    $OSDBuildPackTemp = "$env:TEMP\$(Get-Random)"
    if (!(Test-Path $OSDBuildPackTemp)) {New-Item -Path "$OSDBuildPackTemp" -ItemType Directory -Force | Out-Null}

    #======================================================================================
    #   Get-RegFiles
    #======================================================================================
    [array]$BuildPackContentFiles = @()
    [array]$BuildPackContentFiles = Get-ChildItem "$BuildPackContent" *.reg -Recurse | Select-Object -Property Name, BaseName, Extension, Directory, FullName

    #======================================================================================
    #	Add-OSDBuildPackPERegistryFiles
    #======================================================================================
    foreach ($OSDRegistryRegFile in $BuildPackContentFiles) {
        $OSDRegistryImportFile = $OSDRegistryRegFile.FullName

        if ($MountWinRE) {
            $RegFileContent = Get-Content -Path $OSDRegistryImportFile
            $OSDRegistryImportFile = "$OSDBuildPackTemp\$($OSDRegistryRegFile.BaseName).reg"

            $RegFileContent = $RegFileContent -replace 'HKEY_CURRENT_USER','HKEY_LOCAL_MACHINE\OfflineDefaultUser'
            $RegFileContent = $RegFileContent -replace 'HKEY_LOCAL_MACHINE\\SOFTWARE','HKEY_LOCAL_MACHINE\OfflineSoftware'
            $RegFileContent = $RegFileContent -replace 'HKEY_LOCAL_MACHINE\\SYSTEM','HKEY_LOCAL_MACHINE\OfflineSystem'
            $RegFileContent = $RegFileContent -replace 'HKEY_USERS\\.DEFAULT','HKEY_LOCAL_MACHINE\OfflineDefault'
            $RegFileContent | Set-Content -Path $OSDRegistryImportFile -Force
        }

        Write-Host "$OSDRegistryImportFile"  -ForegroundColor DarkGray
        if ($ShowRegContent.IsPresent){
            $OSDBuildPackRegFileContent = @()
            $OSDBuildPackRegFileContent = Get-Content -Path $OSDRegistryImportFile
            foreach ($Line in $OSDBuildPackRegFileContent) {
                Write-Host "$Line" -ForegroundColor Gray
            }
        }
        Start-Process reg -ArgumentList ('import',"`"$OSDRegistryImportFile`"") -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue
    }
    
    #======================================================================================
    #	Remove-OSDBuildPackTemp
    #======================================================================================
    if ($MountWinRE) {
        if (Test-Path $OSDBuildPackTemp) {Remove-Item -Path "$OSDBuildPackTemp" -Recurse -Force | Out-Null}
    }
    #======================================================================================
    #	Dismount-RegistryHives
    #======================================================================================
    Dismount-OSDOfflineRegistry -MountPath $MountWinRE
        #======================================================================================
    #   Mount-OfflineRegistryHives
    #======================================================================================
    if (($MountWinSE) -and (Test-Path "$MountWinSE" -ErrorAction SilentlyContinue)) {
        Mount-OSDOfflineRegistryPE -MountPath $MountWinSE
    } else {Return}
    $OSDBuildPackTemp = "$env:TEMP\$(Get-Random)"
    if (!(Test-Path $OSDBuildPackTemp)) {New-Item -Path "$OSDBuildPackTemp" -ItemType Directory -Force | Out-Null}

    #======================================================================================
    #   Get-RegFiles
    #======================================================================================
    [array]$BuildPackContentFiles = @()
    [array]$BuildPackContentFiles = Get-ChildItem "$BuildPackContent" *.reg -Recurse | Select-Object -Property Name, BaseName, Extension, Directory, FullName

    #======================================================================================
    #	Add-OSDBuildPackPERegistryFiles
    #======================================================================================
    foreach ($OSDRegistryRegFile in $BuildPackContentFiles) {
        $OSDRegistryImportFile = $OSDRegistryRegFile.FullName

        if ($MountWinSE) {
            $RegFileContent = Get-Content -Path $OSDRegistryImportFile
            $OSDRegistryImportFile = "$OSDBuildPackTemp\$($OSDRegistryRegFile.BaseName).reg"

            $RegFileContent = $RegFileContent -replace 'HKEY_CURRENT_USER','HKEY_LOCAL_MACHINE\OfflineDefaultUser'
            $RegFileContent = $RegFileContent -replace 'HKEY_LOCAL_MACHINE\\SOFTWARE','HKEY_LOCAL_MACHINE\OfflineSoftware'
            $RegFileContent = $RegFileContent -replace 'HKEY_LOCAL_MACHINE\\SYSTEM','HKEY_LOCAL_MACHINE\OfflineSystem'
            $RegFileContent = $RegFileContent -replace 'HKEY_USERS\\.DEFAULT','HKEY_LOCAL_MACHINE\OfflineDefault'
            $RegFileContent | Set-Content -Path $OSDRegistryImportFile -Force
        }

        Write-Host "$OSDRegistryImportFile"  -ForegroundColor DarkGray
        if ($ShowRegContent.IsPresent){
            $OSDBuildPackRegFileContent = @()
            $OSDBuildPackRegFileContent = Get-Content -Path $OSDRegistryImportFile
            foreach ($Line in $OSDBuildPackRegFileContent) {
                Write-Host "$Line" -ForegroundColor Gray
            }
        }
        Start-Process reg -ArgumentList ('import',"`"$OSDRegistryImportFile`"") -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue
    }
    
    #======================================================================================
    #	Remove-OSDBuildPackTemp
    #======================================================================================
    if ($MountWinSE) {
        if (Test-Path $OSDBuildPackTemp) {Remove-Item -Path "$OSDBuildPackTemp" -Recurse -Force | Out-Null}
    }
    #======================================================================================
    #	Dismount-RegistryHives
    #======================================================================================
    Dismount-OSDOfflineRegistry -MountPath $MountWinSE
}
