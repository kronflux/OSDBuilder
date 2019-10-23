function Add-ContentUnattend {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ($OSMajorVersion -ne 10) {Return}
    if ([string]::IsNullOrWhiteSpace($UnattendXML)) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime; Write-Host -ForegroundColor Green "OS: Use Content Unattend"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    Write-Host "$OSDBuilderContent\$UnattendXML" -ForegroundColor DarkGray
    if (!(Test-Path "$MountDirectory\Windows\Panther")) {New-Item -Path "$MountDirectory\Windows\Panther" -ItemType Directory -Force | Out-Null}
    Copy-Item -Path "$OSDBuilderContent\$UnattendXML" -Destination "$MountDirectory\Windows\Panther\Unattend.xml" -Force
    
    $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentUnattend.log"
    Write-Verbose "CurrentLog: $CurrentLog"

    Try {Use-WindowsUnattend -UnattendPath "$OSDBuilderContent\$UnattendXML" -Path "$MountDirectory" -LogPath "$CurrentLog" | Out-Null}
    Catch {
        $ErrorMessage = $_.Exception.Message
        Write-Warning "$ErrorMessage"
    }
}
