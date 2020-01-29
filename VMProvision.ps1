<# VM provisioning script #>

$verprompt = @("Enter the OS you would like to install: 1 for 2016, 2 for 2012, 3 for other")
$vmver = Read-host($verprompt)

switch ( $vmver ){
    1 { $parent = "S:\2016Golden.vhdx"}
    2 { $parent = "S:\2012-R2-Std.vhdx"}
    3 {continue}
}

$VMName = read-host("Enter VM name")
$vhdpath = "E:\VMs\$VMName.vhdx"
#$memory = Read-Host("Enter max memory")
$switch = "vswitch 192"

if(($parent)){
    if(!(test-path $vhdpath)){
        new-vhd -ParentPath $parent -path $vhdpath -differencing
    }
    else {
        write-host "VIRTUAL DISK ALREADY EXISTS!!!"
    }
}
else{
    if(!(test-path $vhdpath)){
        new-vhd -path $vhdpath -dynamic -sizebytes 20000000000
    }
    else {
        write-host "VIRTUAL DISK ALREADY EXISTS!!!"
    }
}

New-VM -VHDPath $vhdpath -Generation 2 -MemoryStartupBytes 4296000000 -Name $VMName -Path "E:\VMs" -switchname $switch
#set-vmmemory $vmname -DynamicMemoryenabled $true -MemoryMaximumBytes 4296000000
