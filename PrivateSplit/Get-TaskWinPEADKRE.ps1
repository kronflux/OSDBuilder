function Get-TaskWinPEADKRE {
    #===================================================================================================
    #   WinRE ADK
    #===================================================================================================
    [CmdletBinding()]
    Param ()
    $WinPEADKRE = Get-ChildItem -Path ("$OSDBuilderContent\WinPE\ADK\*","$OSDBuilderContent\ADK\*\Windows Preinstallation Environment\*\WinPE_OCs") *.cab -Recurse -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName
    
    foreach ($Pack in $WinPEADKRE) {$Pack.FullName = $($Pack.FullName).replace("$OSDBuilderContent\",'')}

    if ($($OSMedia.ReleaseId) -eq 1909) {
        $WinPEADKRE = $WinPEADKRE | Where-Object {$_.FullName -match '1903' -or $_.FullName -match '1909'}
    } else {
        $WinPEADKRE = $WinPEADKRE | Where-Object {$_.FullName -like "*$($OSMedia.ReleaseId)*"}
    }

    if ($OSMedia.Arch -eq 'x86') {$WinPEADKRE = $WinPEADKRE | Where-Object {$_.FullName -like "*x86*"}
    } else {$WinPEADKRE = $WinPEADKRE | Where-Object {($_.FullName -like "*x64*") -or ($_.FullName -like "*amd64*")}}

    $WinPEADKREIE = @()
    $WinPEADKREIE = $ContentIsoExtractWinPE | Select-Object -Property Name, FullName
    [array]$WinPEADKRE = [array]$WinPEADKRE + [array]$WinPEADKREIE

    if ($null -eq $WinPEADKRE) {Write-Warning "WinRE.wim ADK Packages: Add Content to $OSDBuilderContent\ADK"}
    else {
        if ($ExistingTask.WinPEADKRE) {
            foreach ($Item in $ExistingTask.WinPEADKRE) {
                $WinPEADKRE = $WinPEADKRE | Where-Object {$_.FullName -ne $Item}
            }
        }
        Write-Warning "If you add too many ADK Packages to WinRE, like .Net and PowerShell"
        Write-Warning "You run a risk of your WinRE size increasing considerably"
        Write-Warning "If your MBR System or UEFI Recovery Partition are 500MB,"
        Write-Warning "your WinRE.wim should not be more than 400MB (100MB Free)"
        Write-Warning "Consider changing your Task Sequences to have a 984MB"
        Write-Warning "MBR System or UEFI Recovery Partition"
        $WinPEADKRE = $WinPEADKRE | Out-GridView -Title "WinRE.wim ADK Packages: Select ADK Packages to apply and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $WinPEADKRE) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $WinPEADKRE
}
