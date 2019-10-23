function Get-OSDBuilderVersion {
    param (
        [Parameter(Position=1)]
        [switch]$HideDetails
    )
    $global:OSDBuilderVersion = $(Get-Module -Name OSDBuilder).Version
    if ($HideDetails -eq $false) {
        Write-Host "OSDBuilder $OSDBuilderVersion"
        Write-Host ""
    }
}
