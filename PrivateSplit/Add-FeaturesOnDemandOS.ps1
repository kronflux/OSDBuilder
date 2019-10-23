function Add-FeaturesOnDemandOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ([string]::IsNullOrWhiteSpace($FeaturesOnDemand)) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime; Write-Host -ForegroundColor Green "OS: Features On Demand"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    foreach ($FOD in $FeaturesOnDemand) {
        Write-Host $FOD -ForegroundColor DarkGray
        $CurrentLog = "$PEInfo\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-FeaturesOnDemandOS.log"
        Write-Verbose "CurrentLog: $CurrentLog"
        Try {
            Add-WindowsPackage -Path "$MountDirectory" -PackagePath "$OSDBuilderContent\$FOD" -LogPath "$CurrentLog" | Out-Null
        }
        Catch {
            $ErrorMessage = $_.Exception.Message
            Write-Warning "$ErrorMessage"
        }
    }
    Update-CumulativeOS -Force
    Invoke-DismCleanupImage
}
