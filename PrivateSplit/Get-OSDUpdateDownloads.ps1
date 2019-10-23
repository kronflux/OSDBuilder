function Get-OSDUpdateDownloads {
    [CmdletBinding()]
    Param (
        [string]$OSDGuid,
        [string]$UpdateTitle,
        [switch]$Silent
    )
    #===================================================================================================
    #   Filtering
    #===================================================================================================
    if ($OSDGuid) {
        $OSDUpdateDownload = Get-OSDUpdates -Silent | Where-Object {$_.OSDGuid -eq $OSDGuid}
    } elseif ($UpdateTitle) {
        $OSDUpdateDownload = Get-OSDUpdates -Silent | Where-Object {$_.UpdateTitle -eq $UpdateTitle}
    } else {
        Break
    }
    #===================================================================================================
    #   Download
    #===================================================================================================
    foreach ($Update in $OSDUpdateDownload) {
        $DownloadPath = "$OSDBuilderPath\Content\OSDUpdate\$($Update.Catalog)\$($Update.Title)"
        $DownloadFullPath = "$DownloadPath\$($Update.FileName)"
        if (!(Test-Path $DownloadPath)) {New-Item -Path "$DownloadPath" -ItemType Directory -Force | Out-Null}
        if (!(Test-Path $DownloadFullPath)) {
            Write-Host "$DownloadFullPath"
            Write-Host "$($Update.OriginUri)" -ForegroundColor Gray
            $WebClient = New-Object System.Net.WebClient
            $WebClient.DownloadFile("$($Update.OriginUri)","$DownloadFullPath")
            #Start-BitsTransfer -Source $Update.OriginUri -Destination $DownloadFullPath
        }
    }
}
