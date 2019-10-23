function Add-OSDBuildPackOSScripts {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$BuildPackContent
    )
    #======================================================================================
    #   TEST
    #======================================================================================
    if (!(Test-Path "$BuildPackContent\*")) {
        Write-Verbose "Add-OSDBuildPackOSScripts: Unable to locate content in $BuildPackContent"
        Return
    }
    else {Write-Host "$BuildPackContent" -ForegroundColor Cyan}
    #======================================================================================
    #   BUILD
    #======================================================================================
    $BuildPackOSScripts = Get-ChildItem "$BuildPackContent" *.ps1 -File -Recurse | Select-Object -Property FullName
    foreach ($BuildPackOSScript in $BuildPackOSScripts) {
        Write-Host "$($BuildPackOSScript.FullName)" -ForegroundColor DarkGray
        Invoke-Expression "& '$($BuildPackOSScript.FullName)'"
    }
}
