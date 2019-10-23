function Add-OSDBuildPackPEExtraFiles {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$BuildPackContent
    )
    #======================================================================================
    #   Test
    #======================================================================================
    if (!(Test-Path "$BuildPackContent\*")) {
        Write-Verbose "Add-OSDBuildPackPEExtraFiles: Unable to locate content in $BuildPackContent"
        Return
    } else {
        Write-Host "$BuildPackContent" -ForegroundColor Cyan
    }
    #======================================================================================
    #   Import
    #======================================================================================
    $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-OSDBuildPackPEExtraFiles.log"
    Write-Verbose "CurrentLog: $CurrentLog"

    Get-ChildItem "$BuildPackContent" *.* -File -Recurse | Select-Object -Property FullName | foreach {Write-Host "$($_.FullName)" -ForegroundColor DarkGray}

    robocopy "$BuildPackContent" "$MountWinPE" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
    robocopy "$BuildPackContent" "$MountWinRE" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
    robocopy "$BuildPackContent" "$MountWinSE" *.* /e /ndl /xx /b /np /ts /tee /r:0 /w:0 /Log+:"$CurrentLog" | Out-Null
}
