<# Data relocation for ISIR import run daily. File lives on ob-dfs1#>

# this is a good path and we should keep it (for now)
$path1 = '\\Path\1\directory'
$path2 = '\\Path\2\Directory'
$pathtarget = '\\Path\to\move\files\to'


$jobtime = Get-Date
$datestamp = $jobtime.Addhours(-8)

$obj1 = Get-ChildItem $path1 -filter "datafile_*" -file | Where-Object {$_.creationtime -gt $datestamp}
$obj2 = Get-ChildItem $path2 -filter "crw_*" -file | Where-Object {$_.CreationTime -gt $datestamp}

foreach ($file in $obj1){
    $localtarget = $pathtarget + $file.Name
    $file.copyto($localtarget) 
    Write-Output "moved $file to $localtarget at $jobtime" >> C:\scripts\FileRelocation.txt 
}

foreach ($file in $obj2){
    $localtarget = $pathtarget + $file.Name
    $file.CopyTo($localtarget)
    Write-Output "moved $file to $localtarget at $jobtime" >> C:\scripts\Colleagueimport.txt 
}


