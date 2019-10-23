function Get-TaskBuildPacks {
    #===================================================================================================
    #   Content Box 
    #===================================================================================================
    [CmdletBinding()]
    Param ()
    $TaskBuildPacks = Get-ChildItem -Path "$OSDBuilderPath\BuildPacks" -Directory -ErrorAction SilentlyContinue | Select-Object -Property Name

    if ($null -eq $TaskBuildPacks) {Write-Warning "BuildPacks: No Packs exist in $OSDBuilderPath\BuildPacks"}
    else {
        if ($ExistingTask.BuildPacks) {
            foreach ($Item in $ExistingTask.BuildPacks) {
                $TaskBuildPacks = $TaskBuildPacks | Where-Object {$_.Name -ne $Item}
            }
        }
        $TaskBuildPacks = $TaskBuildPacks | Out-GridView -Title "BuildPacks: Select an OSDBuildPack to add to this Task and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $TaskBuildPacks) {Write-Host "$($Item.Name)" -ForegroundColor White}
    Return $TaskBuildPacks
}
