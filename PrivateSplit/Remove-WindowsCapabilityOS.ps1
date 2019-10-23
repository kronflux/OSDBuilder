function Remove-WindowsCapabilityOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ([string]::IsNullOrWhiteSpace($RemoveCapability)) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "OS: Remove Windows Capability"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($Name in $RemoveCapability) {
        Write-Host $Name -ForegroundColor DarkGray
        Try {
            Remove-WindowsCapability -Path "$MountDirectory" -Name $Name -LogPath "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Remove-WindowsCapability.log" | Out-Null
        }
        Catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "$ErrorMessage"
        }
    }
}
