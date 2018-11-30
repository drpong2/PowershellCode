
#region
$badurls = import-csv .\files.csv

foreach ($i in $badurls){
    start-process iexplore.exe $i.'URL/Filename'
    pause
}

#endregion


