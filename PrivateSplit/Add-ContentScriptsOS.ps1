function Add-ContentScriptsOS {
    [CmdletBinding()]
    Param ()
    #===================================================================================================
    #   ABORT
    #===================================================================================================
    if ($ScriptName -ne 'New-OSBuild') {Return}
    #===================================================================================================
    #   TASK
    #===================================================================================================
    if ($Scripts) {
        Show-ActionTime; Write-Host -ForegroundColor Green "OS: Scripts TASK"
        foreach ($Script in $Scripts) {
            if (Test-Path "$OSDBuilderContent\$Script") {
                Write-Host -ForegroundColor Cyan "Source: $OSDBuilderContent\$Script"
                Invoke-Expression "& '$OSDBuilderContent\$Script'"
            }
        }
    }
    #===================================================================================================
    #   TEMPLATE
    #===================================================================================================
    if ($ScriptTemplates) {
        Show-ActionTime; Write-Host -ForegroundColor Green "OS: Scripts TEMPLATE"
        foreach ($Script in $ScriptTemplates) {
            if (Test-Path "$($Script.FullName)") {
                Write-Host -ForegroundColor Cyan "Source: $($Script.FullName)"
                Invoke-Expression "& '$($Script.FullName)'"
            }
        }
    }
}
