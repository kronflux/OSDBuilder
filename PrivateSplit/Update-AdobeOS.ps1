function Update-AdobeOS {
    [CmdletBinding()]
    Param (
        [switch]$Force
    )
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($SkipUpdates) {Return}
    if ($SkipUpdatesOS) {Return}
    if ($OSMajorVersion -ne 10) {Return}
    if ($null -eq $OSDUpdateAdobeSU) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    if ($Force.IsPresent) {
        Write-Host -ForegroundColor Green "OS: (ASU) Adobe Flash Player Security Update (Forced)"
    } else {
        Write-Host -ForegroundColor Green "OS: (ASU) Adobe Flash Player Security Update"
    }
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($Update in $OSDUpdateAdobeSU) {
        $UpdateASU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {($_.FullName -like "*$($Update.Title)*") -and ($_.Name -match "$($Update.FileName)")}).FullName
        if ($null -eq $UpdateASU) {Continue}
        if (!(Test-Path "$UpdateASU")) {Write-Warning "Not Found: $UpdateASU"; Continue}

        if (!($Force.IsPresent)) {
            $SessionsXmlInstall = "$MountDirectory\Windows\Servicing\Sessions\Sessions.xml"
            if (Test-Path $SessionsXmlInstall) {
                [xml]$XmlDocument = Get-Content -Path $SessionsXmlInstall
                if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.FileKBNumber)*" -and $_.targetState -eq 'Installed'}) {
                    Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                    Continue
                }
            }
            if (Get-WindowsPackage -Path "$MountDirectory" | Where-Object {$_.PackageName -match "$($Update.KBNumber)"}) {
                Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                Continue
            }
        }

        Write-Host -ForegroundColor Cyan "INSTALLING        " -NoNewline
        Write-Host -ForegroundColor Gray "$($Update.Title) - $($Update.FileName)"

        $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Update-AdobeOS-KB$($Update.FileKBNumber).log"
        Write-Verbose "CurrentLog: $CurrentLog"
        Try {Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$UpdateASU" -LogPath "$CurrentLog" | Out-Null}
        Catch {
            $ErrorMessage = $_.Exception.$ErrorMessage
            Write-Warning "$CurrentLog"
            Write-Host "$ErrorMessage"
            if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
        }
    }
}
