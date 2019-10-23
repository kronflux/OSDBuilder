function Add-OSDBuildPackPEDaRT {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$BuildPackContent
    )
    #======================================================================================
    #   TEST
    #======================================================================================
    if (!(Test-Path "$BuildPackContent\Tools$($OSArchitecture).cab")) {
        Write-Verbose "Add-OSDBuildPackPEDaRT: Unable to locate content in $BuildPackContent"
        Return
    }
    else {Write-Host "$BuildPackContent\Tools$($OSArchitecture).cab" -ForegroundColor Cyan}
    #======================================================================================
    #   BUILD
    #======================================================================================
    $MicrosoftDartCab = "$BuildPackContent\Tools$($OSArchitecture).cab"

    expand.exe "$MicrosoftDartCab" -F:*.* "$MountWinPE" | Out-Null
    if (Test-Path "$MountWinPE\Windows\System32\winpeshl.ini") {Remove-Item -Path "$MountWinPE\Windows\System32\winpeshl.ini" -Force}
    #===================================================================================================
    expand.exe "$MicrosoftDartCab" -F:*.* "$MountWinRE" | Out-Null
    (Get-Content "$MountWinRE\Windows\System32\winpeshl.ini") | ForEach-Object {$_ -replace '-prompt','-network'} | Out-File "$MountWinRE\Windows\System32\winpeshl.ini"
    #===================================================================================================
    expand.exe "$MicrosoftDartCab" -F:*.* "$MountWinSE" | Out-Null
    if (Test-Path "$MountWinSE\Windows\System32\winpeshl.ini") {Remove-Item -Path "$MountWinSE\Windows\System32\winpeshl.ini" -Force}

    $MicrosoftDartConfig = $(Join-Path $(Split-Path "$MicrosoftDartCab") 'DartConfig.dat')
    if (Test-Path $MicrosoftDartConfig) {
        Copy-Item -Path $MicrosoftDartConfig -Destination "$MountWinPE\Windows\System32\DartConfig.dat" -Force
        Copy-Item -Path $MicrosoftDartConfig -Destination "$MountWinSE\Windows\System32\DartConfig.dat" -Force
        Copy-Item -Path $MicrosoftDartConfig -Destination "$MountWinRE\Windows\System32\DartConfig.dat" -Force
    }
    
    $MicrosoftDartConfig = $(Join-Path $(Split-Path "$MicrosoftDartCab") 'DartConfig8.dat')
    if (Test-Path $MicrosoftDartConfig) {
        Copy-Item -Path $MicrosoftDartConfig -Destination "$MountWinPE\Windows\System32\DartConfig.dat" -Force
        Copy-Item -Path $MicrosoftDartConfig -Destination "$MountWinSE\Windows\System32\DartConfig.dat" -Force
        Copy-Item -Path $MicrosoftDartConfig -Destination "$MountWinRE\Windows\System32\DartConfig.dat" -Force
    }
}
