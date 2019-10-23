function Expand-DaRTPE {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ([string]::IsNullOrWhiteSpace($WinPEDaRT)) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    $MicrosoftDartCab = "$OSDBuilderContent\$WinPEDaRT"
    Write-Host -ForegroundColor Green "Microsoft DaRT: $MicrosoftDartCab"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    if (Test-Path "$MicrosoftDartCab") {
        #===================================================================================================
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
        #===================================================================================================
    } else {Write-Warning "Microsoft DaRT do not exist in $MicrosoftDartCab"}
}
