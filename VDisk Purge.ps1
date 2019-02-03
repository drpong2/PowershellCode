$vms = @()

$vms = get-vm | select-object Name

Write-host "Select from the VMs below"
write-host "==========="
$i = 1
foreach ($vm in $vms){
    write-host "$($i): $($vm.name)"
    $i++
}


$vmarrayindex = read-host ("Enter a number from 1 to {0} to select a VM" -f $vms.count)

$vmselect = $vmarrayindex - 1


$workingvm = get-vm ($vms[$vmselect].Name)

$vhdloc = $workingvm.HardDrives.Path

$vhdloc

$vhdel = read-host ("Unmount and delete? y/n (y)")

<#
$workingvm | get-member

write-host "working VM is " $workingvm.name
$vhdloc = $workingvm.HardDrives.Path
get-vhd $vhdloc



#get-vm -name ($vms[$vmselect].name)

#>
