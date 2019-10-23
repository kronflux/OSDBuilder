function Get-TaskContentStartLayoutXML {
    #===================================================================================================
    #   Content StartLayout
    #===================================================================================================
    [CmdletBinding()]
    Param ()
    $StartLayoutXML = Get-ChildItem -Path "$OSDBuilderContent\StartLayout" *.xml -ErrorAction SilentlyContinue | Select-Object -Property Name, FullName, Length, CreationTime | Sort-Object -Property FullName
    foreach ($Item in $StartLayoutXML) {$Item.FullName = $($Item.FullName).replace("$OSDBuilderContent\",'')}

    if ($null -eq $StartLayoutXML) {Write-Warning "StartLayoutXML: To select a Start Layout, add Content to $OSDBuilderContent\StartLayout"}
    else {
        if ($ExistingTask.StartLayoutXML) {
            foreach ($Item in $ExistingTask.StartLayoutXML) {
                $StartLayoutXML = $StartLayoutXML | Where-Object {$_.FullName -ne $Item}
            }
        }
        $StartLayoutXML = $StartLayoutXML | Out-GridView -Title "StartLayoutXML: Select a Start Layout XML to apply and press OK (Esc or Cancel to Skip)" -OutputMode Single
    }
    foreach ($Item in $StartLayoutXML) {Write-Host "$($Item.FullName)" -ForegroundColor White}
    Return $StartLayoutXML
}
