function Show-OSDBuilderHomeTips {
    [CmdletBinding()]
    Param ()

    Write-Host ''

    Write-Host 'Change OSDBuilder Home Path:                        ' -NoNewline
    Write-Host 'OSDBuilder -SetPath D:\OSDBuilder' -ForegroundColor Cyan

    Write-Host 'Create OSDBuilder Directory Structure:              ' -NoNewline
    Write-Host 'OSDBuilder -CreatePaths' -ForegroundColor Cyan

    Write-Host 'Update OSDBuilder Module to the latest version:     ' -NoNewline
    Write-Host 'OSDBuilder -Update' -ForegroundColor Cyan

    Write-Host ''

    Write-Host 'Download missing Microsoft Updates for OSMedia:     ' -NoNewline
    Write-Host 'OSDBuilder -Download OSMediaUpdates' -ForegroundColor Green

    Write-Host 'Download Windows 10 Feature Updates for Import:     ' -NoNewline
    Write-Host 'OSDBuilder -Download FeatureUpdates' -ForegroundColor Green

    Write-Host 'Download the latest OneDriveSetup.exe:              ' -NoNewline
    Write-Host 'OSDBuilder -Download OneDrive' -ForegroundColor Green

    Write-Host 'Download the latest OneDriveSetup.exe (Enterprise): ' -NoNewline
    Write-Host 'OSDBuilder -Download OneDriveEnterprise' -ForegroundColor Green
    Write-Host ''
}
