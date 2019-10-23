function Add-OSDBuildPack {
    [CmdletBinding()]
    Param (
        #[Alias('Path')]
        #[Parameter(Mandatory)]
        #[string]$BuildPackPath,

        [ValidateSet(
            'Auto',
            'OSDrivers',
            'OSExtraFiles',
            'OSPackages',
            'OSPoshMods',
            'OSRegistry',
            'OSScripts',
            'PEADK',
            'PEDaRT',
            'PEDrivers',
            'PEExtraFiles',
            'PEPackages',
            'PEPoshMods',
            'PERegistry',
            'PEScripts'
        )]
        [Alias('Type')]
        [string]$BuildPackType = 'All'
    )
    #===================================================================================================
    #   ABORT
    #===================================================================================================
    if ($BuildPacksEnabled -eq $false) {Return}
    #===================================================================================================
    #   BUILD
    #===================================================================================================
    if ($BuildPacks) {
        #===================================================================================================
        #   WinPE BuildPacks
        #===================================================================================================
        if ($BuildPackType -eq 'PEADK') {
            Show-ActionTime; Write-Host -ForegroundColor Green "WinPE: BuildPack PEADK"
            foreach ($BuildPack in $BuildPacks) {
                $BuildPackPath = "$OSDBuilderPath\BuildPacks\$BuildPack\PEADK"
                Add-OSDBuildPackPEADK -BuildPackContent "$BuildPackPath\$ReleaseID $OSArchitecture"
            }
        }
        if ($BuildPackType -eq 'PEDaRT') {
            Show-ActionTime; Write-Host -ForegroundColor Green "WinPE: BuildPack PEDaRT"
            foreach ($BuildPack in $BuildPacks) {
                $BuildPackPath = "$OSDBuilderPath\BuildPacks\$BuildPack\PEDaRT"
                Add-OSDBuildPackPEDaRT -BuildPackContent "$BuildPackPath"
            }
        }
        if ($BuildPackType -eq 'PEDrivers') {
            Show-ActionTime; Write-Host -ForegroundColor Green "WinPE: BuildPack PEDrivers"
            foreach ($BuildPack in $BuildPacks) {
                $BuildPackPath = "$OSDBuilderPath\BuildPacks\$BuildPack\PEDrivers"
                Add-OSDBuildPackPEDrivers -BuildPackContent "$BuildPackPath\ALL"
                Add-OSDBuildPackPEDrivers -BuildPackContent "$BuildPackPath\$OSArchitecture"
            }
        }
        if ($BuildPackType -eq 'PEExtraFiles') {
            Show-ActionTime; Write-Host -ForegroundColor Green "WinPE: BuildPack PEExtraFiles"
            foreach ($BuildPack in $BuildPacks) {
                $BuildPackPath = "$OSDBuilderPath\BuildPacks\$BuildPack\PEExtraFiles"
                Add-OSDBuildPackPEExtraFiles -BuildPackContent "$BuildPackPath\ALL"
                Add-OSDBuildPackPEExtraFiles -BuildPackContent "$BuildPackPath\$OSArchitecture"
            }
        }
        if ($BuildPackType -eq 'PEPoshMods') {
            Show-ActionTime; Write-Host -ForegroundColor Green "WinPE: BuildPack PEPoshMods"
            foreach ($BuildPack in $BuildPacks) {
                $BuildPackPath = "$OSDBuilderPath\BuildPacks\$BuildPack\PEPoshMods"
                Add-OSDBuildPackPEPoshMods -BuildPackContent "$BuildPackPath\ALL"
            }
        }
        if ($BuildPackType -eq 'PERegistry') {
            Show-ActionTime; Write-Host -ForegroundColor Green "WinPE: BuildPack PERegistry"
            foreach ($BuildPack in $BuildPacks) {
                $BuildPackPath = "$OSDBuilderPath\BuildPacks\$BuildPack\PERegistry"
                Add-OSDBuildPackPERegistry -BuildPackContent "$BuildPackPath\ALL"
                Add-OSDBuildPackPERegistry -BuildPackContent "$BuildPackPath\$OSArchitecture"
            }
        }
        if ($BuildPackType -eq 'PEScripts') {
            Show-ActionTime; Write-Host -ForegroundColor Green "WinPE: BuildPack PEScripts"
            foreach ($BuildPack in $BuildPacks) {
                $BuildPackPath = "$OSDBuilderPath\BuildPacks\$BuildPack\PEScripts"
                Add-OSDBuildPackPEScripts -BuildPackContent "$BuildPackPath\ALL"
                Add-OSDBuildPackPEScripts -BuildPackContent "$BuildPackPath\$OSArchitecture"
            }
        }
        #===================================================================================================
        #   OS BuildPacks
        #===================================================================================================
        if ($BuildPackType -eq 'OSDrivers') {
            Show-ActionTime; Write-Host -ForegroundColor Green "OS: BuildPack OSDrivers"
            foreach ($BuildPack in $BuildPacks) {
                $BuildPackPath = "$OSDBuilderPath\BuildPacks\$BuildPack\OSDrivers"
                Add-OSDBuildPackOSDrivers -BuildPackContent "$BuildPackPath\ALL"
                Add-OSDBuildPackOSDrivers -BuildPackContent "$BuildPackPath\$OSArchitecture"
            }
        }
        if ($BuildPackType -eq 'OSExtraFiles') {
            Show-ActionTime; Write-Host -ForegroundColor Green "OS: BuildPack OSExtraFiles"
            foreach ($BuildPack in $BuildPacks) {
                $BuildPackPath = "$OSDBuilderPath\BuildPacks\$BuildPack\OSExtraFiles"
                Add-OSDBuildPackOSExtraFiles -BuildPackContent "$BuildPackPath\ALL"
                Add-OSDBuildPackOSExtraFiles -BuildPackContent "$BuildPackPath\$OSArchitecture"
            }
        }
        if ($BuildPackType -eq 'OSPoshMods') {
            Show-ActionTime; Write-Host -ForegroundColor Green "OS: BuildPack OSPoshMods"
            foreach ($BuildPack in $BuildPacks) {
                $BuildPackPath = "$OSDBuilderPath\BuildPacks\$BuildPack\OSPoshMods"
                Add-OSDBuildPackOSPoshMods -BuildPackContent "$BuildPackPath\ALL"
            }
        }
        if ($BuildPackType -eq 'OSRegistry') {
            Show-ActionTime; Write-Host -ForegroundColor Green "OS: BuildPack OSRegistry"
            foreach ($BuildPack in $BuildPacks) {
                $BuildPackPath = "$OSDBuilderPath\BuildPacks\$BuildPack\OSRegistry"
                Add-OSDBuildPackOSRegistry -BuildPackContent "$BuildPackPath\ALL"
                Add-OSDBuildPackOSRegistry -BuildPackContent "$BuildPackPath\$OSArchitecture"
            }
        }
        if ($BuildPackType -eq 'OSScripts') {
            Show-ActionTime; Write-Host -ForegroundColor Green "WinPE: BuildPack OSScripts"
            foreach ($BuildPack in $BuildPacks) {
                $BuildPackPath = "$OSDBuilderPath\BuildPacks\$BuildPack\OSScripts"
                Add-OSDBuildPackOSScripts -BuildPackContent "$BuildPackPath\ALL"
                Add-OSDBuildPackOSScripts -BuildPackContent "$BuildPackPath\$OSArchitecture"
            }
        }
    }
}
