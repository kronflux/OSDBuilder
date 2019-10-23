function Add-OSDBuildPackPEScripts {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$BuildPackContent
    )
    #======================================================================================
    #   TEST
    #======================================================================================
    if (!(Test-Path "$BuildPackContent\*")) {
        Write-Verbose "Add-OSDBuildPackPEScripts: Unable to locate content in $BuildPackContent"
        Return
    }
    else {Write-Host "$BuildPackContent" -ForegroundColor Cyan}
    #======================================================================================
    #   BUILD
    #======================================================================================
    $BuildPackPEScripts = Get-ChildItem "$BuildPackContent" *.ps1 -File -Recurse | Select-Object -Property FullName
    foreach ($BuildPackPEScript in $BuildPackPEScripts) {
        Write-Host "$($BuildPackPEScript.FullName)" -ForegroundColor DarkGray
        Invoke-Expression "& '$($BuildPackPEScript.FullName)'"
    }
}
