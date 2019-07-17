<# Sophos fix for the network scanner#>

set-itemproperty -path "HKCR:\AppID\{C092D533-8791-42F8-8EBE-DB116F79B4B7" -name "SntpService" -value "SophosNtpService"
