function Get-TaskContentIsoExtract {
    [CmdletBinding()]
    Param ()
    $ContentIsoExtract = Get-ChildItem -Path "$OSDBuilderContent\IsoExtract\*" -Include *.cab, *.appx -Recurse | Select-Object -Property Name, FullName
    if ($($OSMedia.ReleaseId)) {
        if ($($OSMedia.ReleaseId) -eq 1909) {
            $AddFeatureOnDemand = $AddFeatureOnDemand | Where-Object {$_.FullName -match '1903' -or $_.FullName -match '1909'}
        } else {
            $ContentIsoExtract = $ContentIsoExtract | Where-Object {$_.FullName -like "*$($OSMedia.ReleaseId)*"}
        }
    }
    foreach ($IsoExtractPackage in $ContentIsoExtract) {$IsoExtractPackage.FullName = $($IsoExtractPackage.FullName).replace("$OSDBuilderContent\",'')}

    $ContentIsoExtract = $ContentIsoExtract | Where-Object {$_.FullName -notlike "*\arm64\*"}

    if ($($OSMedia.Arch) -eq 'x64') {$ContentIsoExtract = $ContentIsoExtract | Where-Object {$_.Name -notlike "*x86*"}}
    if ($($OSMedia.Arch) -eq 'x64') {$ContentIsoExtract = $ContentIsoExtract | Where-Object {$_.FullName -notlike "*\x86\*"}}

    if ($($OSMedia.Arch) -eq 'x86') {$ContentIsoExtract = $ContentIsoExtract | Where-Object {$_.Name -notlike "*x64*"}}
    if ($($OSMedia.Arch) -eq 'x86') {$ContentIsoExtract = $ContentIsoExtract | Where-Object {$_.Name -notlike "*amd64*"}}
    if ($($OSMedia.Arch) -eq 'x86') {$ContentIsoExtract = $ContentIsoExtract | Where-Object {$_.FullName -notlike "*\x64\*"}}
    if ($($OSMedia.Arch) -eq 'x86') {$ContentIsoExtract = $ContentIsoExtract | Where-Object {$_.FullName -notlike "*\amd64\*"}}

    Return $ContentIsoExtract
}
