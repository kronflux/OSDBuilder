function Save-RegistryCurrentVersionOS {
    [CmdletBinding()]
    Param ()
    $RegKeyCurrentVersion | Out-File "$Info\CurrentVersion.txt"
    $RegKeyCurrentVersion | Out-File "$WorkingPath\CurrentVersion.txt"
    $RegKeyCurrentVersion | Out-File "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-CurrentVersion.txt"
    $RegKeyCurrentVersion | Export-Clixml -Path "$Info\xml\CurrentVersion.xml"
    $RegKeyCurrentVersion | Export-Clixml -Path "$Info\xml\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-CurrentVersion.xml"
    $RegKeyCurrentVersion | ConvertTo-Json | Out-File "$Info\json\CurrentVersion.json"
    $RegKeyCurrentVersion | ConvertTo-Json | Out-File "$Info\json\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-CurrentVersion.json"
}
