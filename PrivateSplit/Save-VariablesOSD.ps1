function Save-VariablesOSD {
    [CmdletBinding()]
    Param ()
    Get-Variable | Select-Object -Property Name, Value | Export-Clixml "$Info\xml\Variables.xml"
    Get-Variable | Where-Object { $_.Value -isnot [System.Collections.Hashtable] } | Select-Object -Property Name, Value | ConvertTo-Json | Out-File "$Info\json\Variables.json"
}
