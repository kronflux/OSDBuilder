function Add-ContentDriversOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   Abort
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    #===================================================================================================
    #   Task
    #===================================================================================================
    if ($Drivers) {
        Show-ActionTime; Write-Host -ForegroundColor Green "OS: Drivers TASK"
        foreach ($Driver in $Drivers) {
            Write-Host "$OSDBuilderContent\$Driver" -ForegroundColor DarkGray

            $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentDriversOS-Task.log"
            Write-Verbose "CurrentLog: $CurrentLog"

            if ($OSMajorVersion -eq 6) {
                dism /Image:"$MountDirectory" /Add-Driver /Driver:"$OSDBuilderContent\$Driver" /Recurse /ForceUnsigned /LogPath:"$CurrentLog"
            } else {
                Add-WindowsDriver -Driver "$OSDBuilderContent\$Driver" -Recurse -Path "$MountDirectory" -ForceUnsigned -LogPath "$CurrentLog" | Out-Null
            }
        }
    }
    #===================================================================================================
    #   Template
    #===================================================================================================
    if ($DriverTemplates) {
        Show-ActionTime; Write-Host -ForegroundColor Green "OS: Drivers TEMPLATE"
        foreach ($Driver in $DriverTemplates) {
            Write-Host "$($Driver.FullName)" -ForegroundColor DarkGray

            $CurrentLog = "$Info\logs\$((Get-Date).ToString('yyyy-MM-dd-HHmmss'))-Add-ContentDriversOS-Template.log"
            Write-Verbose "CurrentLog: $CurrentLog"

            if ($OSMajorVersion -eq 6) {
                dism /Image:"$MountDirectory" /Add-Driver /Driver:"$($Driver.FullName)" /Recurse /ForceUnsigned /LogPath:"$CurrentLog"
            } else {
                Add-WindowsDriver -Driver "$($Driver.FullName)" -Recurse -Path "$MountDirectory" -ForceUnsigned -LogPath "$CurrentLog" | Out-Null
            }
        }
    }
}
