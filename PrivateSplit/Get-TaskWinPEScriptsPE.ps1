function Get-TaskWinPEScriptsPE {
    #===================================================================================================
    #   WinPE PowerShell Scripts
    #===================================================================================================
    [CmdletBinding()]
    Param ()
    $WinPEScriptsPE = Get-ChildItem -Path ("$OSDBuilderContent\Scripts","$OSDBuilderContent\WinPE\Scripts") *.ps1 -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName, Length, CreationTime | Sort-Object -Property FullName
    foreach ($TaskScript in $WinPEScriptsPE) {$TaskScript.FullName = $($TaskScript.FullName).replace("$OSDBuilderContent\",'')}
    if ($null -eq $WinPEScriptsPE) {Write-Warning "WinPE PowerShell Scripts: To select PowerShell Scripts add Content to $OSDBuilderContent\Scripts"}
    else {
        if ($ExistingTask.WinPEScriptsPE) {
            foreach ($Item in $ExistingTask.WinPEScriptsPE) {
                $WinPEScriptsPE = $WinPEScriptsPE | Where-Object {$_.FullName -ne $Item}
            }
        }
        $WinPEScriptsPE = $WinPEScriptsPE | Out-GridView -Title "WinPE PowerShell Scripts: Select PowerShell Scripts to execute and press OK (Esc or Cancel to Skip)" -PassThru
    }
    foreach ($Item in $WinPEScriptsPE) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $WinPEScriptsPE
}
