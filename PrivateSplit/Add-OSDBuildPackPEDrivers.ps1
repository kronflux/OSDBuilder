function Add-OSDBuildPackPEDrivers {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$BuildPackContent
    )
    #======================================================================================
    #   Test
    #======================================================================================
    if (!(Test-Path "$BuildPackContent\*")) {
        Write-Verbose "Add-OSDBuildPackPEDrivers: Unable to locate content in $BuildPackContent"
        Return
    } else {
        Write-Host "$BuildPackContent" -ForegroundColor Cyan
    }
    #======================================================================================
    #   Import
    #======================================================================================
    $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-OSDBuildPackPEDrivers.log"
    Write-Verbose "CurrentLog: $CurrentLog"

    Get-ChildItem "$BuildPackContent" *.inf -File -Recurse | Select-Object -Property FullName | foreach {Write-Host "$($_.FullName)" -ForegroundColor DarkGray}

    if ($OSMajorVersion -eq 6) {
        dism /Image:"$MountWinPE" /Add-Driver /Driver:"$BuildPackContent" /Recurse /ForceUnsigned /LogPath:"$CurrentLog"
        dism /Image:"$MountWinRE" /Add-Driver /Driver:"$BuildPackContent" /Recurse /ForceUnsigned /LogPath:"$CurrentLog"
        dism /Image:"$MountWinSE" /Add-Driver /Driver:"$BuildPackContent" /Recurse /ForceUnsigned /LogPath:"$CurrentLog"
    } else {
        Add-WindowsDriver -Driver "$BuildPackContent" -Recurse -Path "$MountWinPE" -ForceUnsigned -LogPath "$CurrentLog" | Out-Null
        Add-WindowsDriver -Driver "$BuildPackContent" -Recurse -Path "$MountWinRE" -ForceUnsigned -LogPath "$CurrentLog" | Out-Null
        Add-WindowsDriver -Driver "$BuildPackContent" -Recurse -Path "$MountWinSE" -ForceUnsigned -LogPath "$CurrentLog" | Out-Null
    }
}
