function Add-ContentStartLayout {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ($OSMajorVersion -ne 10) {Return}
    if ([string]::IsNullOrWhiteSpace($StartLayoutXML)) {Return}
    #===================================================================================================
    #   TASK
    #===================================================================================================
    Show-ActionTime; Write-Host -ForegroundColor Green "OS: Use Content StartLayout"
    Write-Host "$OSDBuilderContent\$StartLayoutXML" -ForegroundColor DarkGray
    Try {
        Copy-Item -Path "$OSDBuilderContent\$StartLayoutXML" -Destination "$MountDirectory\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml" -Recurse -Force | Out-Null
    }
    Catch {
        $ErrorMessage = $_.Exception.Message
        Write-Warning "$ErrorMessage"
    }
}
