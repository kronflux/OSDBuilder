function Update-ServicingStackPE {
    [CmdletBinding()]
    Param (
        [switch]$Force
    )
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($SkipUpdates) {Return}
    if ($SkipUpdatesPE) {Return}
    if ($SkipUpdatesPESSU) {Return}
    #if ($OSMajorVersion -ne 10) {Return}
    if ($null -eq $OSDUpdateSSU) {Return}
    #===================================================================================================
    #   Update WinPE
    #===================================================================================================
    if ($OSMajorVersion -ne 10) {
        $OSDUpdateSSU = $OSDUpdateSSU | Where-Object {$_.OSDWinPE -eq $true}
        if ($Force.IsPresent) {Return}
    }
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinPE: (SSU) Servicing Stack Update"
    if ($OSBuild -ge 18362) {
        Write-Warning "Skipping update for this version of Windows"
        Return
    }

    foreach ($Update in $OSDUpdateSSU) {
        $UpdateSSU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {($_.FullName -like "*$($Update.Title)*") -and ($_.Name -match "$($Update.FileName)")}).FullName
        if ($null -eq $UpdateSSU) {Continue}
        if (!(Test-Path "$UpdateSSU")) {Write-Warning "Not Found: $UpdateSSU"; Continue}

        if (!($Force.IsPresent)) {
            if (Get-WindowsPackage -Path "$MountWinPE" | Where-Object {$_.PackageName -match "$($Update.KBNumber)"}) {
                Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                Continue
            }
        }

        Write-Host -ForegroundColor Cyan "INSTALLING        " -NoNewline
        Write-Host -ForegroundColor Gray "$($Update.Title) - $($Update.FileName)"

        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Update-ServicingStackPE-KB$($Update.KBNumber)-WinPE.log"
        Write-Verbose "CurrentLog: $CurrentLog"
        Try {Add-WindowsPackage -Path "$MountWinPE" -PackagePath "$UpdateSSU" -LogPath "$CurrentLog" | Out-Null}
        Catch {
            $ErrorMessage = $_.Exception.$ErrorMessage
            Write-Warning "$CurrentLog"
            Write-Host "$ErrorMessage"
            if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
        }
    }
    #===================================================================================================
    #   Update WinRE
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinRE: (SSU) Servicing Stack Update"
    foreach ($Update in $OSDUpdateSSU) {
        $UpdateSSU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {($_.FullName -like "*$($Update.Title)*") -and ($_.Name -match "$($Update.FileName)")}).FullName
        if ($null -eq $UpdateSSU) {Continue}
        if (!(Test-Path "$UpdateSSU")) {Write-Warning "Not Found: $UpdateSSU"; Continue}

        if (!($Force.IsPresent)) {
            if (Get-WindowsPackage -Path "$MountWinRE" | Where-Object {$_.PackageName -match "$($Update.KBNumber)"}) {
                Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                Continue
            }
        }

        Write-Host -ForegroundColor Cyan "INSTALLING        " -NoNewline
        Write-Host -ForegroundColor Gray "$($Update.Title) - $($Update.FileName)"
        
        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Update-ServicingStackPE-KB$($Update.KBNumber)-WinRE.log"
        Write-Verbose "CurrentLog: $CurrentLog"
        Try {Add-WindowsPackage -Path "$MountWinRE" -PackagePath "$UpdateSSU" -LogPath "$CurrentLog" | Out-Null}
        Catch {
            $ErrorMessage = $_.Exception.$ErrorMessage
            Write-Warning "$CurrentLog"
            Write-Host "$ErrorMessage"
            if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
        }
    }
    #===================================================================================================
    #   Update WinSE
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "WinSE: (SSU) Servicing Stack Update"
    foreach ($Update in $OSDUpdateSSU) {
        $UpdateSSU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {($_.FullName -like "*$($Update.Title)*") -and ($_.Name -match "$($Update.FileName)")}).FullName
        if ($null -eq $UpdateSSU) {Continue}
        if (!(Test-Path "$UpdateSSU")) {Write-Warning "Not Found: $UpdateSSU"; Continue}

        if (!($Force.IsPresent)) {
            if (Get-WindowsPackage -Path "$MountWinSE" | Where-Object {$_.PackageName -match "$($Update.KBNumber)"}) {
                Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                Continue
            }
        }

        Write-Host -ForegroundColor Cyan "INSTALLING        " -NoNewline
        Write-Host -ForegroundColor Gray "$($Update.Title) - $($Update.FileName)"
        
        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Update-ServicingStackPE-KB$($Update.KBNumber)-WinSE.log"
        Write-Verbose "CurrentLog: $CurrentLog"
        Try {Add-WindowsPackage -Path "$MountWinSE" -PackagePath "$UpdateSSU" -LogPath "$CurrentLog" | Out-Null}
        Catch {
            $ErrorMessage = $_.Exception.$ErrorMessage
            Write-Warning "$CurrentLog"
            Write-Host "$ErrorMessage"
            if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
        }
    }
}
