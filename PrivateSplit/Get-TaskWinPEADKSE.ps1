function Get-TaskWinPEADKSE {
    #===================================================================================================
    #   WinRE ADK
    #===================================================================================================
    [CmdletBinding()]
    Param ()
    $WinPEADKSE = Get-ChildItem -Path ("$OSDBuilderContent\WinPE\ADK\*","$OSDBuilderContent\ADK\*\Windows Preinstallation Environment\*\WinPE_OCs") *.cab -Recurse -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName
    foreach ($Pack in $WinPEADKSE) {$Pack.FullName = $($Pack.FullName).replace("$OSDBuilderContent\",'')}

    if ($($OSMedia.ReleaseId) -eq 1909) {
        $WinPEADKSE = $WinPEADKSE | Where-Object {$_.FullName -match '1903' -or $_.FullName -match '1909'}
    } else {
        $WinPEADKSE = $WinPEADKSE | Where-Object {$_.FullName -like "*$($OSMedia.ReleaseId)*"}
    }

    if ($OSMedia.Arch -eq 'x86') {$WinPEADKSE = $WinPEADKSE | Where-Object {$_.FullName -like "*x86*"}
    } else {$WinPEADKSE = $WinPEADKSE | Where-Object {($_.FullName -like "*x64*") -or ($_.FullName -like "*amd64*")}}

    $WinPEADKSEIE = @()
    $WinPEADKSEIE = $ContentIsoExtractWinPE | Select-Object -Property Name, FullName
    [array]$WinPEADKSE = [array]$WinPEADKSE + [array]$WinPEADKSEIE

    if ($null -eq $WinPEADKSE) {Write-Warning "WinSE.wim ADK Packages: Add Content to $OSDBuilderContent\ADK"}
    else {
        if ($ExistingTask.WinPEADKSE) {
            foreach ($Item in $ExistingTask.WinPEADKSE) {
                $WinPEADKSE = $WinPEADKSE | Where-Object {$_.FullName -ne $Item}
            }
        }
        $WinPEADKSE = $WinPEADKSE | Out-GridView -Title "WinSE.wim ADK Packages: Select ADK Packages to apply and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $WinPEADKSE) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $WinPEADKSE
}
