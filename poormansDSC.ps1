<# Poor Man's DSC
Get list of installed windows features from one computer to install on another computer.

Must be run from the server that you'd like to update.
#>

read-host -prompt "Please enter target computer"

try{
    test-netconnection $targetcomputer
    $proceed = 1
}
catch{
    "Connection Failed!"
    $proceed = 0
}
if($proceed){
    $installed = invoke-command $targetcomputer -scriptblock {get-windowsfeature | where {$_.installstate -eq "installed"}}
    foreach ($install in $installed){
    install-windowsfeature $install.name
    }
}