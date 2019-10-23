function New-OSDBuilderCreatePaths {
    [CmdletBinding()]
    Param ()

    $OSDBuilderHomeDirectories = @(
        $OSDBuilderPath
        $OSDBuilderOSBuilds
        $OSDBuilderOSImport
        $OSDBuilderOSMedia
        $OSDBuilderPEBuilds
        $OSDBuilderTasks
        $OSDBuilderTemplates
        $OSDBuilderContent
        "$OSDBuilderContent\ADK"
        "$OSDBuilderContent\ADK\Windows 10 1903\Windows Preinstallation Environment"
        "$OSDBuilderContent\ADK\Windows 10 1909\Windows Preinstallation Environment"
        "$OSDBuilderContent\DaRT"
        "$OSDBuilderContent\DaRT\DaRT 10"
        "$OSDBuilderContent\Drivers"
        "$OSDBuilderContent\ExtraFiles"
        "$OSDBuilderContent\IsoExtract"
        "$OSDBuilderContent\IsoExtract\Windows 10 1903 FOD x64"
        "$OSDBuilderContent\IsoExtract\Windows 10 1903 FOD x64"
        "$OSDBuilderContent\IsoExtract\Windows 10 1903 Language"
        "$OSDBuilderContent\IsoExtract\Windows 10 1909 Language"
        "$OSDBuilderContent\IsoExtract\Windows Server 2019 1809 FOD x64"
        "$OSDBuilderContent\IsoExtract\Windows Server 2019 1809 Language"
        #"$OSDBuilderContent\LanguagePacks"
        "$OSDBuilderContent\Mount"
        "$OSDBuilderContent\OneDrive"
        "$OSDBuilderContent\OSDUpdate"
        "$OSDBuilderContent\Packages"
        #"$OSDBuilderContent\Packages\Win10 x64 1809"
        #"$OSDBuilderContent\Provisioning"
        #"$OSDBuilderContent\Registry"
        "$OSDBuilderContent\Scripts"
        "$OSDBuilderContent\StartLayout"
        "$OSDBuilderContent\Unattend"
        #"$OSDBuilderContent\Updates"
        #"$OSDBuilderContent\Updates\Custom"
        #"$OSDBuilderContent\WinPE"
        #"$OSDBuilderContent\WinPE\ADK\Win10 x64 1809"
        #"$OSDBuilderContent\WinPE\DaRT\DaRT 10"
        #"$OSDBuilderContent\WinPE\Drivers"
        #"$OSDBuilderContent\WinPE\Drivers\WinPE 10 x64"
        #"$OSDBuilderContent\WinPE\Drivers\WinPE 10 x86"
        #"$OSDBuilderContent\WinPE\ExtraFiles"
        #"$OSDBuilderContent\WinPE\Scripts"
    )

    foreach ($item in $OSDBuilderHomeDirectories) {
        if (!(Test-Path "$item")) {New-Item "$item" -ItemType Directory -Force | Out-Null}
    }

    if ($BuildPacksEnabled = $true) {
        $OSDBuilderHomeDirectories = @(
            $OSDBuilderBuildPacks
            "$OSDBuilderBuildPacks\_Mandatory\OSDrivers\ALL"
            "$OSDBuilderBuildPacks\_Mandatory\OSDrivers\x64"
            "$OSDBuilderBuildPacks\_Mandatory\OSDrivers\x86"
            "$OSDBuilderBuildPacks\_Mandatory\OSExtraFiles\ALL"
            "$OSDBuilderBuildPacks\_Mandatory\OSExtraFiles\x64"
            "$OSDBuilderBuildPacks\_Mandatory\OSExtraFiles\x86"
            "$OSDBuilderBuildPacks\_Mandatory\OSPoshMods\ALL"
            "$OSDBuilderBuildPacks\_Mandatory\OSRegistry\ALL"
            "$OSDBuilderBuildPacks\_Mandatory\OSRegistry\x64"
            "$OSDBuilderBuildPacks\_Mandatory\OSRegistry\x86"
            "$OSDBuilderBuildPacks\_Mandatory\OSScripts\ALL"
            "$OSDBuilderBuildPacks\_Mandatory\OSScripts\x64"
            "$OSDBuilderBuildPacks\_Mandatory\OSScripts\x86"
            "$OSDBuilderBuildPacks\_Mandatory\PEADK\1809 x64"
            "$OSDBuilderBuildPacks\_Mandatory\PEADK\1809 x86"
            "$OSDBuilderBuildPacks\_Mandatory\PEADK\1903 x64"
            "$OSDBuilderBuildPacks\_Mandatory\PEADK\1903 x86"
            "$OSDBuilderBuildPacks\_Mandatory\PEADK\1909 x64"
            "$OSDBuilderBuildPacks\_Mandatory\PEADK\1909 x86"
            "$OSDBuilderBuildPacks\_Mandatory\PEDrivers\ALL"
            "$OSDBuilderBuildPacks\_Mandatory\PEDrivers\x64"
            "$OSDBuilderBuildPacks\_Mandatory\PEDrivers\x86"
            "$OSDBuilderBuildPacks\_Mandatory\PEExtraFiles\ALL"
            "$OSDBuilderBuildPacks\_Mandatory\PEExtraFiles\x64"
            "$OSDBuilderBuildPacks\_Mandatory\PEExtraFiles\x86"
            "$OSDBuilderBuildPacks\_Mandatory\PEPoshMods\ALL"
            "$OSDBuilderBuildPacks\_Mandatory\PERegistry\ALL"
            "$OSDBuilderBuildPacks\_Mandatory\PERegistry\x64"
            "$OSDBuilderBuildPacks\_Mandatory\PERegistry\x86"
            "$OSDBuilderBuildPacks\_Mandatory\PEScripts\ALL"
            "$OSDBuilderBuildPacks\_Mandatory\PEScripts\x64"
            "$OSDBuilderBuildPacks\_Mandatory\PEScripts\x86"
            "$OSDBuilderBuildPacks\_Template\OSDrivers\ALL"
            "$OSDBuilderBuildPacks\_Template\OSDrivers\x64"
            "$OSDBuilderBuildPacks\_Template\OSDrivers\x86"
            "$OSDBuilderBuildPacks\_Template\OSExtraFiles\ALL"
            "$OSDBuilderBuildPacks\_Template\OSExtraFiles\x64"
            "$OSDBuilderBuildPacks\_Template\OSExtraFiles\x86"
            "$OSDBuilderBuildPacks\_Template\OSPoshMods\ALL"
            "$OSDBuilderBuildPacks\_Template\OSRegistry\ALL"
            "$OSDBuilderBuildPacks\_Template\OSRegistry\x64"
            "$OSDBuilderBuildPacks\_Template\OSRegistry\x86"
            "$OSDBuilderBuildPacks\_Template\OSScripts\ALL"
            "$OSDBuilderBuildPacks\_Template\OSScripts\x64"
            "$OSDBuilderBuildPacks\_Template\OSScripts\x86"
            "$OSDBuilderBuildPacks\_Template\PEADK\1809 x64"
            "$OSDBuilderBuildPacks\_Template\PEADK\1809 x86"
            "$OSDBuilderBuildPacks\_Template\PEADK\1903 x64"
            "$OSDBuilderBuildPacks\_Template\PEADK\1903 x86"
            "$OSDBuilderBuildPacks\_Template\PEADK\1909 x64"
            "$OSDBuilderBuildPacks\_Template\PEADK\1909 x86"
            "$OSDBuilderBuildPacks\_Template\PEDrivers\ALL"
            "$OSDBuilderBuildPacks\_Template\PEDrivers\x64"
            "$OSDBuilderBuildPacks\_Template\PEDrivers\x86"
            "$OSDBuilderBuildPacks\_Template\PEExtraFiles\ALL"
            "$OSDBuilderBuildPacks\_Template\PEExtraFiles\x64"
            "$OSDBuilderBuildPacks\_Template\PEExtraFiles\x86"
            "$OSDBuilderBuildPacks\_Template\PEPoshMods\ALL"
            "$OSDBuilderBuildPacks\_Template\PERegistry\ALL"
            "$OSDBuilderBuildPacks\_Template\PERegistry\x64"
            "$OSDBuilderBuildPacks\_Template\PERegistry\x86"
            "$OSDBuilderBuildPacks\_Template\PEScripts\ALL"
            "$OSDBuilderBuildPacks\_Template\PEScripts\x64"
            "$OSDBuilderBuildPacks\_Template\PEScripts\x86"
        )
        foreach ($item in $OSDBuilderHomeDirectories) {
            if (!(Test-Path "$item")) {New-Item "$item" -ItemType Directory -Force | Out-Null}
        }
    }
}
