<# Code to slipstream Windows ISOs #>

if(!(test-path C:\Mount\)){
    new-item -ItemType Directory C:\Mount\
}

#$SourceMachine = Read-Host "What is your source machine?"
#$Path = "\\" + $SourceMachine + "\c$\Windows\SoftwareDistribution\Download"
$Path = "C:\slipstream\Download"
$Cabs = Get-ChildItem -Path "$Path" -Recurse -Include *.cab | Sort LastWriteTime 
try {Mount-WindowsImage -ImagePath C:\install.wim -Index 2 -Path C:\Mount\ -erroraction "stop"}
catch {
    "Mount failed!"
    $_
}
ForEach ($Cab in $Cabs){
    Add-WindowsPackage -Path C:\Mount -PackagePath $Cab.FullName
    if ($? -eq $TRUE){
        $Cab.Name | Out-File -FilePath .\Updates-Sucessful.log -Append
    } else {    
        $Cab.Name | Out-File -FilePath .\Updates-Failed.log -Append
    }
}
Dismount-WindowsImage -Path C:\Mount -Save

