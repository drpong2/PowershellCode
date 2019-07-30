<# Sophos fix for the network scanner#>


if(!(get-item "HKLM:\SOFTWARE\Classes\AppID\{C092D533-8791-42F8-8EBE-DB116F79B4B7}")){
new-item -path "HKLM:\SOFTWARE\Classes\AppID\" -name "{C092D533-8791-42F8-8EBE-DB116F79B4B7}"
new-itemproperty -path "HKLM:\SOFTWARE\Classes\AppID\{C092D533-8791-42F8-8EBE-DB116F79B4B7}" -name "SntpService" -value "SophosNtpService" -propertytype "string"
}

#get-content "$env:windir\Panther\MigLog.xml" | select-string "{C092D533-8791-42F8-8EBE-DB116F79B4B7}"
