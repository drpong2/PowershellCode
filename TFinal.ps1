#Tech Final
get-vm | stop-vm -force
get-vm | remove-vm
#(It'll prompt if you're sure, hit A for All)
remove-item 'C:\hyper-v\virtual hard disks\*.vhdx'
try
{new-item -itemtype directory -path 'C:\TechFinal' -erroraction stop}
catch [System.IO.IOException]
{write-output "Folder already exists"}
write-host "Please move the 2012 R2 Std to the C:\techfinal directory to continue..."
read-host
write-host "tada!"
$parentvhd = get-childitem "C:\TechFinal" -File
$parentvhd[0].FullName
rename-item $parentvhd[0].fullname -newname 'C:\techfinal\2012parent.vhdx'
$parent = "C:\techfinal\2012parent.vhdx"
$VHDs = "C:\TechFinal\TFDC1.vhdx", "C:\TechFinal\TFDC2.vhdx", "C:\TechFinal\TFDHCP3.vhdx", "C:\TechFinal\TFFS4.vhdx", "C:\TechFinal\TFMGMT5.vhdx"
$switch = "TF"
if (!(get-vmswitch -name $switch -erroraction SilentlyContinue)){
New-VMSwitch -name $switch -SwitchType Private
}
foreach ($vhd in $VHDs){
New-VHD -ParentPath $parent -Path $vhd -Differencing
}

New-VM -VHDPath "C:\TechFinal\TFDC1.vhdx" -Generation 2 -MemoryStartupBytes 4296000000 -Name TFDC1 -Path "C:\techfinal" -switchname $switch
New-VM -VHDPath "C:\TechFinal\TFDC2.vhdx" -Generation 2 -MemoryStartupBytes 4296000000 -Name TFDC2 -Path "C:\techfinal" -switchname $switch
New-VM -VHDPath "C:\TechFinal\TFFS4.vhdx" -Generation 2 -MemoryStartupBytes 4296000000 -Name TFFS4 -Path "C:\techfinal" -switchname $switch
New-VM -VHDPath "C:\TechFinal\TFDHCP3.vhdx" -Generation 2 -MemoryStartupBytes 4296000000 -Name TFDHCP3 -Path "C:\techfinal" -switchname $switch
New-VM -VHDPath "C:\TechFinal\TFMGMT5.vhdx" -Generation 2 -MemoryStartupBytes 4296000000 -Name TFMGMT -Path "C:\techfinal" -switchname $switch
