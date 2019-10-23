function Set-WinREWimOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "OS: Replace $MountDirectory\Windows\System32\Recovery\winre.wim"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if (Test-Path "$MountDirectory\Windows\System32\Recovery\winre.wim") {
        Remove-Item -Path "$MountDirectory\Windows\System32\Recovery\winre.wim" -Force
    }

    Copy-Item -Path "$WinPE\winre.wim" -Destination "$MountDirectory\Windows\System32\Recovery\winre.wim" -Force | Out-Null
    $GetWindowsImage = @()
    $GetWindowsImage = Get-WindowsImage -ImagePath "$WinPE\winre.wim" -Index 1 | Select-Object -Property *
    $GetWindowsImage | Out-File "$PEInfo\Get-WindowsImage-WinRE.txt"
    (Get-Content "$PEInfo\Get-WindowsImage-WinRE.txt") | Where-Object {$_.Trim(" `t")} | Set-Content "$PEInfo\Get-WindowsImage-WinRE.txt"
    $GetWindowsImage | Out-File "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Get-WindowsImage-WinRE.txt"
    $GetWindowsImage | Export-Clixml -Path "$PEInfo\xml\Get-WindowsImage-WinRE.xml"
    $GetWindowsImage | Export-Clixml -Path "$PEInfo\xml\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Get-WindowsImage-WinRE.xml"
    $GetWindowsImage | ConvertTo-Json | Out-File "$PEInfo\json\Get-WindowsImage-WinRE.json"
    $GetWindowsImage | ConvertTo-Json | Out-File "$PEInfo\json\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Get-WindowsImage-WinRE.json"
}
