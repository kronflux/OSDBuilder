function Add-OSDBuildPackOSDrivers {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$BuildPackContent
        #[string]$MountDirectory
    )
    #======================================================================================
    #   Test
    #======================================================================================
    if (!(Test-Path "$BuildPackContent\*")) {
        Write-Verbose "Add-OSDBuildPackOSDrivers: Unable to locate content in $BuildPackContent"
        Return
    } else {
        Write-Host "$BuildPackContent" -ForegroundColor Cyan
    }
    #======================================================================================
    #   Import
    #======================================================================================
    $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-OSDBuildPackOSDrivers.log"
    Write-Verbose "CurrentLog: $CurrentLog"

    Get-ChildItem "$BuildPackContent" *.inf -File -Recurse | Select-Object -Property FullName | foreach {Write-Host "$($_.FullName)" -ForegroundColor DarkGray}

    if ($OSMajorVersion -eq 6) {
        dism /Image:"$MountDirectory" /Add-Driver /Driver:"$BuildPackContent" /Recurse /ForceUnsigned /LogPath:"$CurrentLog"
    } else {
        Add-WindowsDriver -Driver "$BuildPackContent" -Recurse -Path "$MountDirectory" -ForceUnsigned -LogPath "$CurrentLog" | Out-Null
    }
}
