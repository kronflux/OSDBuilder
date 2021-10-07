﻿$Catalog = Import-Clixml "D:\GitHub\Modules\OSDBuilder\Catalogs\Windows 10.xml"
$CatalogErrors = @()
$CatalogCorrections = @()

foreach ($item in $Catalog) {
    if ($($item.FileName) -notlike "*$($item.KBNumber)*") {   
        $CatalogErrors += $item
    }

    $pattern = 'KB(\d{4,6})'
    $FileKBNumber = [regex]::matches($item.FileName, $pattern).Value
    $TitleKBNumber = [regex]::matches($item.FileName, $pattern).Value


}
$CatalogErrors | Out-GridView