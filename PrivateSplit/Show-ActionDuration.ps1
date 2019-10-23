function Show-ActionDuration {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Show-ActionDuration
    #===================================================================================================
    $OSDDuration = $(Get-Date) - $Global:OSDStartTime
    Write-Host -ForegroundColor DarkGray "Duration: $($OSDDuration.ToString('mm\:ss'))"
    #===================================================================================================
}
