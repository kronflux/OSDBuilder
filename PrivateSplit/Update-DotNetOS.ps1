function Update-DotNetOS {
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
    if ($null -eq $OSDUpdateDotNet) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    if ($Force.IsPresent) {
        Write-Host -ForegroundColor Green "OS: (NetCU) DotNet Framework Cumulative Update (Forced)"
    } else {
        Write-Host -ForegroundColor Green "OS: (NetCU) DotNet Framework Cumulative Update"
    }
    #===================================================================================================
    #   Execute DotNet
    #===================================================================================================
    foreach ($Update in $OSDUpdateDotNet | Where-Object {$_.UpdateGroup -eq 'DotNet'}) {
        $UpdateNetCU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {($_.FullName -like "*$($Update.Title)*") -and ($_.Name -match "$($Update.FileName)")}).FullName
        if ($null -eq $UpdateNetCU) {Continue}
        if (!(Test-Path "$UpdateNetCU")) {Write-Warning "Not Found: $UpdateNetCU"; Continue}
        
        $SessionsXmlInstall = "$MountDirectory\Windows\Servicing\Sessions\Sessions.xml"
        if (Test-Path $SessionsXmlInstall) {
            [xml]$XmlDocument = Get-Content -Path $SessionsXmlInstall
            if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.FileKBNumber)*" -and $_.targetState -eq 'Installed'}) {
                Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                Continue
            }
        }
        
        Write-Host -ForegroundColor Cyan "INSTALLING        " -NoNewline
        Write-Host -ForegroundColor Gray "$($Update.Title) - $($Update.FileName)"

        $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Update-DotNetOS-KB$($Update.FileKBNumber).log"
        Write-Verbose "CurrentLog: $CurrentLog"
        Try {Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$UpdateNetCU" -LogPath "$CurrentLog" | Out-Null}
        Catch {
            $ErrorMessage = $_.Exception.$ErrorMessage
            Write-Warning "$CurrentLog"
            Write-Host "$ErrorMessage"
            if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
            if ($ErrorMessage -like "*0x8007371b*") {
                Write-Warning "ERROR_SXS_TRANSACTION_CLOSURE_INCOMPLETE"
                Write-Warning "One or more required members of the transaction are not present"
                Write-Warning "Since this is a DotNet Update, it is quite possible this won't install until you enable a DotNet Feature like NetFX 3.5"
            }
        }
    }
    #===================================================================================================
    #   Execute DotNetCU
    #===================================================================================================
    foreach ($Update in $OSDUpdateDotNet | Where-Object {$_.UpdateGroup -eq 'DotNetCU'}) {
        $UpdateNetCU = $(Get-ChildItem -Path $OSDBuilderContent\OSDUpdate -File -Recurse | Where-Object {($_.FullName -like "*$($Update.Title)*") -and ($_.Name -match "$($Update.FileName)")}).FullName
        if ($null -eq $UpdateNetCU) {Continue}
        if (!(Test-Path "$UpdateNetCU")) {Write-Warning "Not Found: $UpdateNetCU"; Continue}
        
        if (!($Force.IsPresent)) {
            $SessionsXmlInstall = "$MountDirectory\Windows\Servicing\Sessions\Sessions.xml"
            if (Test-Path $SessionsXmlInstall) {
                [xml]$XmlDocument = Get-Content -Path $SessionsXmlInstall
                if ($XmlDocument.Sessions.Session.Tasks.Phase.package | Where-Object {$_.Name -like "*$($Update.FileKBNumber)*" -and $_.targetState -eq 'Installed'}) {
                    Write-Host -ForegroundColor Gray "INSTALLED         $($Update.Title) - $($Update.FileName)"
                    Continue
                }
            }
        }
        
        Write-Host -ForegroundColor Cyan "INSTALLING        " -NoNewline
        Write-Host -ForegroundColor Gray "$($Update.Title) - $($Update.FileName)"

        $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Update-DotNetOS-KB$($Update.FileKBNumber).log"
        Write-Verbose "CurrentLog: $CurrentLog"
        Try {Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$UpdateNetCU" -LogPath "$CurrentLog" | Out-Null}
        Catch {
            $ErrorMessage = $_.Exception.$ErrorMessage
            Write-Warning "$CurrentLog"
            Write-Host "$ErrorMessage"
            if ($ErrorMessage -like "*0x800f081e*") {Write-Warning "Update not applicable to this Operating System"}
            if ($ErrorMessage -like "*0x8007371b*") {
                Write-Warning "ERROR_SXS_TRANSACTION_CLOSURE_INCOMPLETE"
                Write-Warning "One or more required members of the transaction are not present"
                Write-Warning "Since this is a DotNet Update, it is quite possible this won't install until you enable a DotNet Feature like NetFX 3.5"
            }
        }
    }
}
