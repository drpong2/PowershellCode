<# Reg detailed daily tests
.SYNOPSIS extract a file, then save as .csv, then parse/run excel com object

#>
#$regdetailed = 'C:\workspace\Registration Detailed Yesterday 82218  0800 AM .zip'


#7z.exe e *.zip

# This is the working set
$regextract = 'C:\scripts\Registration Detailed Yesterday.xls'
$excel = new-object -comobject "excel.application"
$workbook = $excel.workbooks.open($regextract)
$excel.visible = $true

$wsname = $workbook.activesheet.name()
do{
    $workbook.Worksheets($wsname).rows("1").delete()
} while ($workbook.worksheets($wsname).range('A1').value -eq '')

#read-host -prompt "Go ahead and reformat the originator DN cell"
$thiswb = $workbook.worksheets($wsname)
$rowscount = ($thiswb.UsedRange.rows).count
$rowscount

#region
for ($i = 0; $i -le $rowscount; $i++){
    $odn = $thiswb.cells($i,5).value()
    if ($odn -eq ''){
        $thiswb.rows($i).delete()
    }
    elseif ($odn -eq 'anonymous'){
        $thiswb.rows($i).delete()
    }
    elseif (-not $odn){
        $thiswb.rows($i).delete()
    }
}
write-host "Empty values removed"
$rowscount = ($thiswb.UsedRange.rows).count

#endregion

#region
For ($dn = 2; $dn -le $rowscount; $dn++){
    $odd = $thiswb.cells($dn,4).value()
    $odn = $thiswb.cells($dn,5).value()
    If ($odd -eq "2"){ 
        for ($j = 2; $j -le $rowscount; $j++){
            $jdn = $thiswb.cells($j,5).value()
            $jda = $thiswb.cells($j,4).value()
            if ($odn -eq $jdn){
                if ($dn -lt $j){
                    $thiswb.rows($j).delete()
                    $rowscount = ($thiswb.usedrange.rows).count
                    $j = 1
                }
                elseif ($jda -eq '1'){
                    $thiswb.rows($j).delete()
                    $rowscount = ($thiswb.usedrange.rows).count
                    $j = 1
                }
            }
        }
    }
}
write-host "Duplicates removed!"
read-host -prompt "press any key to continue..."
$rowscount = ($thiswb.UsedRange.rows).count
#endregion


#region
For($dn = 1; $dn -le $rowscount; $dn++){
    $odn = $thiswb.cells($dn,4).value()
    If ($odn -eq "2"){ 
        $thiswb.rows($dn).delete()
        $rowscount = ($thiswb.usedrange.rows).count
        $dn = 1  
    }
}
$rowscount = ($thiswb.usedrange.rows).count

For ($dn = 2; $dn -le $rowscount; $dn++){
    $odn = $thiswb.cells($dn,5).value()
    for ($j = 2; $j -le $rowscount; $j++){
        $jdn = $thiswb.cells($j,5).value()
        if ($odn -eq $jdn){
            if ($dn -lt $j){
                $thiswb.rows($j).delete()
                $rowscount = ($thiswb.usedrange.rows).count
                $j = 2
            }
        }
    }
}

$rowscount = ($thiswb.UsedRange.rows).count

write-host "entering color-coding"
For ($j = 1; $j -le $rowscount; $j++){
    $blank = $thiswb.cells($j,10).value()
    If (-not $blank){
        For ($k = 1; $k -le 14; $k++){
            $thiswb.cells($j,$k).Interior.ColorIndex = 6
        }
    }
}

$rowscount = ($thiswb.usedrange.rows).count
#endregion
$date = (get-date).ToShortDateString()
$fsdate = $date.Replace('/','-')
$xlsxPath = 'C:\scripts\'
$saveloc = $xlsxPath + 'abandonedCalls.' + $fsdate + '.xlsx'
$workbook.SaveAs($saveloc)



<#$excel = New-Object -ComObject Excel.Application
$excel.Visible = $true
$workbook = $excel.Workbooks.Add()
# or $workbook = $excel.Workbooks.Open($xlsxPath)

# do work with Excel...

$workbook.SaveAs($xlsxPath)
$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel)
# no $ needed on variable name in Remove-Variable call
Remove-Variable excel
#>