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
if($workingvm.state -ne "Off"){
    $StopVM = read-host ("Virtual Machine is not turned off! Turn off now? y/n (n)")
    switch ($StopVM)
    {
        "Y" {stop-vm $workingvm}
        default { exit } 
    }
    start-sleep -seconds 2
}

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
