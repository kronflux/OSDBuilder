function Show-ActionTime {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Show-ActionTime
    #===================================================================================================
    $Global:OSDStartTime = Get-Date
    Write-Host -ForegroundColor White "$(($Global:OSDStartTime).ToString('yyyy-MM-dd-HHmmss')) " -NoNewline
    #Write-Host -ForegroundColor DarkGray "[$(($Global:OSDStartTime).ToString('yyyy-MM-dd-HHmmss'))] " -NoNewline
    #===================================================================================================
}
