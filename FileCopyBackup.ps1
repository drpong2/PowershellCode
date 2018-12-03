<# Data relocation for data import run daily. File lives on Server1#>
$jobtime = Get-Date

Switch( $jobtime.Month )
 {
     1 { $month = 'Jan'}
     2 { $month = 'Feb'}
     3 { $month = 'Mar'}
     4 { $month = 'Apr'}
     5 { $month = 'May'}
     6 { $month = 'Jun'}
     7 { $month = 'Jul'}
     8 { $month = 'Aug'}
     9 { $month = 'Sep'}
     10 { $month = 'Oct'}
     11 { $month = 'Nov'}
     12 { $month = 'Dec'}
 }
# this is a good path and we should keep it (for now)
$path1 = '\\Path\1\directory' + $jobtime.year + '\' + $month
$path2 = '\\Path\2\Directory' + $jobtime.year + '\' + $month
$pathtarget = '\\Path\to\move\files\to'

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


