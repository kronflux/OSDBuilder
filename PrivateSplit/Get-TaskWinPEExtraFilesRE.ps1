function Get-TaskWinPEExtraFilesRE {
    #===================================================================================================
    #   WinPEExtraFilesRE
    #===================================================================================================
    [CmdletBinding()]
    Param ()
    $WinPEExtraFilesRE = Get-ChildItem -Path ("$OSDBuilderContent\ExtraFiles","$OSDBuilderContent\WinPE\ExtraFiles") -Directory -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName
    $WinPEExtraFilesRE = $WinPEExtraFilesRE | Where-Object {(Get-ChildItem $_.FullName | Measure-Object).Count -gt 0}
    foreach ($Pack in $WinPEExtraFilesRE) {$Pack.FullName = $($Pack.FullName).replace("$OSDBuilderContent\",'')}
    if ($null -eq $WinPEExtraFilesRE) {Write-Warning "WinPEExtraFilesRE: To select WinRE Extra Files, add Content to $OSDBuilderContent\ExtraFiles"}
    else {
        if ($ExistingTask.WinPEExtraFilesRE) {
            foreach ($Item in $ExistingTask.WinPEExtraFilesRE) {
                $WinPEExtraFilesRE = $WinPEExtraFilesRE | Where-Object {$_.FullName -ne $Item}
            }
        }
        $WinPEExtraFilesRE = $WinPEExtraFilesRE | Out-GridView -Title "WinPEExtraFilesRE: Select directories to inject and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $WinPEExtraFilesRE) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $WinPEExtraFilesRE
}
