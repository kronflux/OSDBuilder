<#
.SYNOPSIS
Creates a new OSDBuilder Update Catalog XML

.DESCRIPTION
Creates a new OSDBuilder Update Catalog XML for use with Get-OSDUpdateBuilder

.LINK
https://osdbuilder.osdeploy.com/module/functions/new-osdupdatebuilder

.PARAMETER Category
Category of the Update

.PARAMETER Description
Description of the Update

.PARAMETER Category
Category of the Update

.PARAMETER KBNumber
KB Number of the Update

.PARAMETER OS
Operating System the Update applies to

.PARAMETER OSArch
Operating System Architecture the Update applies to

.PARAMETER OSBuild
Operating System Build Number the Update applies to

.PARAMETER ReleaseDay
Day of the Release

.PARAMETER ReleaseMonth
Month of the Release

.PARAMETER ReleaseYear
Year of the Release

.PARAMETER URL
Download link of the Update

#>
function Use-OSDUpdateBuilder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateSet(
            'Windows 10 Custom',
            'Windows 11 Custom',
            'Windows Server 2016 Custom',
            'Windows Server 2019 Custom')]
        [string]$Catalog,

        [Parameter(Mandatory)]
        [string]$KBTitle,
        
        [Parameter(Mandatory)]
        [string]$KBNumber,

        [Parameter(Mandatory)]
        [ValidateSet('Windows 11','Windows 10','Windows Server 2022')]
        [string]$UpdateOS,

        [Parameter(Mandatory)]
        [ValidateSet('x64','x86')]
        [string]$UpdateArch,

        [Parameter(Mandatory)]
        [ValidateSet ('24H2','23H2','22H2','21H2')]
        [string]$UpdateBuild,

        [ValidateSet('DotNet','DotNetCU','LCU','SSU')]
        [string]$UpdateGroup,

        [datetime]$ReleaseDate,

        [ValidateSet('01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31')]
        [string]$ReleaseDay,
        

        [ValidateSet('01','02','03','04','05','06','07','08','09','10','11','12')]
        [string]$ReleaseMonth,


        [ValidateSet('2024','2023','2022','2021','2020','2019','2018','2017')]
        [string]$ReleaseYear,

        [Parameter(Mandatory)]
        [string]$URL,

        [switch]$WinPE
    )

    Begin {
        #=================================================
        Write-Verbose '19.1.1 Initialize OSDBuilder'
        #=================================================
        Get-OSDBuilder -CreatePaths -HideDetails
    }

    Process {
        Write-Host '========================================================================================' -ForegroundColor DarkGray
        Write-Host -ForegroundColor Green "$($MyInvocation.MyCommand.Name) PROCESS"

        #=================================================
        #   Create Custom Object
        #=================================================
        $OSDUpdateBuilder = New-Object PSObject
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name Catalog -Value $Catalog
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name OSDVersion -Value $global:GetOSDBuilder.VersionOSDBuilder
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name OSDStatus -Value ''
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name UpdateOS -Value $UpdateOS
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name UpdateBuild -Value $UpdateBuild
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name UpdateArch -Value $UpdateArch
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name UpdateGroup -Value $UpdateGroup
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name CreationDate -Value $([datetime]"$(($ReleaseDate).ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss"))")
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name KBNumber -Value $KBNumber
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name Title -Value $KBTitle
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name LegacyName -Value ''
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name Type -Value 'SelfContained'
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name FileName -Value "$(Split-Path $URL -Leaf)"
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name Size -Value ''
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name CompanyTitles -Value ''
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name ProductFamilyTitles -Value ''
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name Category -Value $UpdateOS
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name UpdateClassificationTitle -Value ''
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name MsrcSeverity -Value ''
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name SecurityBulletins -Value ''
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name UpdateType -Value 'Software'
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name PublicationState -Value 'Published'
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name HasLicenseAgreement -Value $false
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name RequiresLicenseAgreementAcceptance -Value $false
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name State -Value 'Ready'
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name IsLatestRevision -Value $true
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name HasEarlierRevision -Value $false
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name IsBeta -Value $false
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name HasStaleUpdateApprovals -Value $false
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name IsApproved -Value $false
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name IsDeclined -Value $false
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name HasSupersededUpdates -Value $false
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name IsSuperseded -Value $false
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name IsWsusInfrastructureUpdate -Value $false
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name IsEditable -Value $false
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name UpdateSource -Value 'MicrosoftUpdate'
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name AdditionalInformationUrls -Value "http://support.microsoft.com/help/$KBNumber"
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name Description -Value ''
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name ReleaseNotes -Value ''
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name FileUri -Value $URL
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name OriginUri -Value $URL
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name Hash -Value ''
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name AdditionalHash -Value ''
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name OSDCore -Value $OSDCore
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name OSDWinPE -Value $WinPE
        Add-Member -InputObject $OSDUpdateBuilder -MemberType NoteProperty -Name OSDGuid -Value New-Guid
        #=================================================
        #   Create OSDBuilder Update Category Directory
        #=================================================
        if (!(Test-Path "$SetOSDBuilderPathUpdates")) {New-Item -Path "$SetOSDBuilderPathUpdates" -ItemType Directory -Force | Out-Null}

        #=================================================
        #   Create OSDBuilder Update Catalog
        #=================================================
        $OSDUpdateBuilder | Export-Clixml -Path "$SetOSDBuilderPathUpdates\$Catalog $KBTitle.xml"
    }

    End {
    }
}