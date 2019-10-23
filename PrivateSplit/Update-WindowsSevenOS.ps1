function Update-WindowsSevenOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'Update-OSMedia') {Return}
    if ($SkipUpdates) {Return}
    if ($OSMajorVersion -eq 10) {Return}
    if ($null -eq $OSDUpdateWinSeven) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "OS: Windows 7 Updates"
    $SessionsXmlInstall = "$MountDirectory\Windows\Servicing\Sessions\Sessions.xml"
    if (Test-Path $SessionsXmlInstall) {
        [xml]$XmlDocument = Get-Content -Path $SessionsXmlInstall
    }
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($Update in $OSDUpdateWinSeven) {
        $UpdateSeven = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {($_.FullName -like "*$($Update.Title)*") -and ($_.Name -match "$($Update.FileName)")}).FullName
        $UpdateSeven = $UpdateSeven | Select-Object -First 1

        if ($null -eq $UpdateSeven) {Continue}
        if (!(Test-Path "$UpdateSeven")) {Write-Warning "Not Found: $UpdateSeven"; Continue}

        if (Test-Path $SessionsXmlInstall) {
            if ($null -eq $Update.FileKBNumber) {
                if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.KBNumber)*" -and $_.targetState -eq 'Installed'}) {
                    Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                    Continue
                }
            } else {
                if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.FileKBNumber)*" -and $_.targetState -eq 'Installed'}) {
                    Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                    Continue
                }
            }
        }

        #Get updated Sessions.xml and check again
        if (Test-Path $SessionsXmlInstall) {
            [xml]$XmlDocument = Get-Content -Path $SessionsXmlInstall
        }

        if (Test-Path $SessionsXmlInstall) {
            if ($null -eq $Update.FileKBNumber) {
                if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.KBNumber)*" -and $_.targetState -eq 'Installed'}) {
                    Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                    Continue
                }
            } else {
                if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.FileKBNumber)*" -and $_.targetState -eq 'Installed'}) {
                    Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                    Continue
                }
            }
        }

        if ($null -eq $Update.FileKBNumber) {
            $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Update-WindowsSevenOS-KB$($Update.KBNumber).log"
            if (Get-WindowsPackage -Path "$MountDirectory" | Where-Object {$_.PackageName -match "$($Update.KBNumber)"}) {
                Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                Continue
            }
        } else {
            $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Update-WindowsSevenOS-KB$($Update.FileKBNumber).log"
            if (Get-WindowsPackage -Path "$MountDirectory" | Where-Object {$_.PackageName -match "$($Update.FileKBNumber)"}) {
                Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                Continue
            }
        }

        Write-Host -ForegroundColor Cyan "INSTALLING        " -NoNewline
        Write-Host -ForegroundColor Gray "$($Update.Title) - $($Update.FileName)"

        Write-Verbose "CurrentLog: $CurrentLog"
        Try {Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$UpdateSeven" -LogPath "$CurrentLog" | Out-Null}
        Catch {
            $ErrorMessage = $_.Exception.$ErrorMessage
            Write-Warning "$CurrentLog"
            Write-Host "$ErrorMessage"
            if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
        }
    }
}
