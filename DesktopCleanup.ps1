$path = Join-Path -Path $env:USERPROFILE -ChildPath 'Desktop'


$desktopcsv = gci $path -filter *.csv | where-object {$_.name -like '*REG*'}
$dregfolder = join-path -path $path -ChildPath 'DREG'

foreach($file in $desktopcsv){
    move-item $file.pspath -Destination $dregfolder
}
