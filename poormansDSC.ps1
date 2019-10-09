<# Poor Man's DSC
Get list of installed windows features from one computer to install on another computer.
#>

read-host -prompt "Please enter target computer"
$installed = invoke-command $targetcomputer -scriptblock {get-windowsfeature | where {$_.installstate -eq "installed"}}
foreach ($install in $installed){
install-windowsfeature $install.name
}