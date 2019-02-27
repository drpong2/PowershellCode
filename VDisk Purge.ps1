$VirtualMachines = @()

$VirtualMachines = Get-VM | Select-Object Name

Write-host "Select from the virtual machines below `n `n"

$i = 1
ForEach ($vm in $VirtualMachines)
{
    Write-Host "$($i): $($vm.name)"
    $i++
}


$vmarrayindex = read-host ("Enter a number from 1 to {0} to select a virtual machine" -f $VirtualMachines.count)

$vmselect = $vmarrayindex - 1

$workingvm = Get-VM ($VirtualMachines[$vmselect].Name)

$VHDlocation = $workingvm.HardDrives.Path

$VHDLocation

$VHDDelAction = Read-Host ("Unmount and delete? y/n (n)")

switch ($VHDDelAction)
{
    "Y" {Remove-Item $VHDLocation}
    default { exit } 
}

$VMDelAction = Read-Host "The VHD file located at $VHDLocation has been deleted. `nWould you like to remove the following virtual machine: $workingvm y/n (n)"

switch ($VMDelAction)
{
    "Y" {Remove-VM $workingvm.name}
    default { exit } 
}
