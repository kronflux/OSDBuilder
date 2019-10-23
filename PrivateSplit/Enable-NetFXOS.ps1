function Enable-NetFXOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    if ($EnableNetFX3 -ne $true) {Return}
    if ($OSMajorVersion -ne 10) {Return}
    #===================================================================================================
    #   Header
    #===================================================================================================
    Show-ActionTime
    Write-Host -ForegroundColor Green "OS: Enable NetFX 3.5"
    #===================================================================================================
    #   Execute
    #===================================================================================================
    $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Enable-NetFXOS.log"
    Write-Verbose "CurrentLog: $CurrentLog"
    Try {
        Enable-WindowsOptionalFeature -Path "$MountDirectory" -FeatureName NetFX3 -All -LimitAccess -Source "$OS\sources\sxs" -LogPath "$CurrentLog" | Out-Null
    }
    Catch {
        $ErrorMessage = $_.Exception.Message
        Write-Warning "$ErrorMessage"
    }
    #===================================================================================================
    #   Post Action
    #===================================================================================================
    Update-DotNetOS -Force
    Update-CumulativeOS -Force
    #===================================================================================================
}
