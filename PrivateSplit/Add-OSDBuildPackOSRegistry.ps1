function Add-OSDBuildPackOSRegistry {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$BuildPackContent,

        [switch]$ShowRegContent
    )

    #======================================================================================
    #   Test-OSDBuildPackOSRegistry
    #======================================================================================
    if (!(Test-Path "$BuildPackContent\*")) {
        Write-Verbose "Add-OSDBuildPackOSRegistry: Unable to locate content in $BuildPackContent"
        Return
    } else {
        Write-Host "$BuildPackContent" -ForegroundColor Cyan
    }

    #======================================================================================
    #   Mount-OfflineRegistryHives
    #======================================================================================
    if (($MountDirectory) -and (Test-Path "$MountDirectory" -ErrorAction SilentlyContinue)) {
        if (Test-Path "$MountDirectory\Users\Default\NTUser.dat") {
            Write-Verbose "Loading Offline Registry Hive Default User" 
            Start-Process reg -ArgumentList "load HKLM\OfflineDefaultUser $MountDirectory\Users\Default\NTUser.dat" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue
        }
        if (Test-Path "$MountDirectory\Windows\System32\Config\DEFAULT") {
            Write-Verbose "Loading Offline Registry Hive DEFAULT" 
            Start-Process reg -ArgumentList "load HKLM\OfflineDefault $MountDirectory\Windows\System32\Config\DEFAULT" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue
        }
        if (Test-Path "$MountDirectory\Windows\System32\Config\SOFTWARE") {
            Write-Verbose "Loading Offline Registry Hive SOFTWARE" 
            Start-Process reg -ArgumentList "load HKLM\OfflineSoftware $MountDirectory\Windows\System32\Config\SOFTWARE" -Wait -WindowStyle Hidden -ErrorAction Stop
        }
        if (Test-Path "$MountDirectory\Windows\System32\Config\SYSTEM") {
            Write-Verbose "Loading Offline Registry Hive SYSTEM" 
            Start-Process reg -ArgumentList "load HKLM\OfflineSystem $MountDirectory\Windows\System32\Config\SYSTEM" -Wait -WindowStyle Hidden -ErrorAction Stop
        }
        $OSDBuildPackTemp = "$env:TEMP\$(Get-Random)"
        if (!(Test-Path $OSDBuildPackTemp)) {New-Item -Path "$OSDBuildPackTemp" -ItemType Directory -Force | Out-Null}
    }

    #======================================================================================
    #   Get-RegFiles
    #======================================================================================
    [array]$BuildPackContentFiles = @()
    [array]$BuildPackContentFiles = Get-ChildItem "$BuildPackContent" *.reg -Recurse | Select-Object -Property Name, BaseName, Extension, Directory, FullName

    #======================================================================================
    #	Add-OSDBuildPackOSRegistryFiles
    #======================================================================================
    foreach ($OSDRegistryRegFile in $BuildPackContentFiles) {
        $OSDRegistryImportFile = $OSDRegistryRegFile.FullName

        if ($MountDirectory) {
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
    if ($MountDirectory) {
        if (Test-Path $OSDBuildPackTemp) {Remove-Item -Path "$OSDBuildPackTemp" -Recurse -Force | Out-Null}
    }

    #======================================================================================
    #	Dismount-RegistryHives
    #======================================================================================
    Dismount-OSDOfflineRegistry -MountPath $MountDirectory
}
