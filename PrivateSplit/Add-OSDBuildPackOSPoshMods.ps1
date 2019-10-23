function Add-OSDBuildPackOSPoshMods {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$BuildPackContent
    )
    #======================================================================================
    #   Test
    #======================================================================================
    if (!(Test-Path "$BuildPackContent\*")) {
        Write-Verbose "Add-OSDBuildPackOSPoshMods: Unable to locate content in $BuildPackContent"
        Return
    } else {
        Write-Host "$BuildPackContent" -ForegroundColor Cyan
    }
    #======================================================================================
    #   Import
    #======================================================================================
    $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-OSDBuildPackOSPoshMods.log"
    Write-Verbose "CurrentLog: $CurrentLog"

    Get-ChildItem "$BuildPackContent" *.* -File -Recurse | Select-Object -Property FullName | foreach {Write-Host "$($_.FullName)" -ForegroundColor DarkGray}

    robocopy "$BuildPackContent" "$MountDirectory\Program Files\WindowsPowerShell\Modules" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
}
