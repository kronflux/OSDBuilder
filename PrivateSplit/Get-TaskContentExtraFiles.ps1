function Get-TaskContentExtraFiles {
    #===================================================================================================
    #   Content ExtraFiles
    #===================================================================================================
    [CmdletBinding()]
    Param ()
    $ExtraFiles = Get-ChildItem -Path "$OSDBuilderContent\ExtraFiles" -Directory -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName
    $ExtraFiles = $ExtraFiles | Where-Object {(Get-ChildItem $_.FullName | Measure-Object).Count -gt 0}
    foreach ($Pack in $ExtraFiles) {$Pack.FullName = $($Pack.FullName).replace("$OSDBuilderContent\",'')}

    if ($null -eq $ExtraFiles) {Write-Warning "Extra Files: To select Extra Files, add Content to $OSDBuilderContent\ExtraFiles"}
    else {
        if ($ExistingTask.ExtraFiles) {
            foreach ($Item in $ExistingTask.ExtraFiles) {
                $ExtraFiles = $ExtraFiles | Where-Object {$_.FullName -ne $Item}
            }
        }
        $ExtraFiles = $ExtraFiles | Out-GridView -Title "Extra Files: Select directories to inject and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $ExtraFiles) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $ExtraFiles
}
