<# swgoh.gg player API
v. 0.3
author: Marsa Ruwes
#>

function show-toptoons($toons){
    return $toons
}
function show-toptoonsaverage($toons){
    [int]$topvaluesum = 0
    foreach ($val in $toons){
        $topvaluesum += $val.power
    }
    [int]$returnsum = "$topvaluesum" / "$toptoons"
    return $returnsum
}
function show-subpar($toons){
    return $toons | select -last ($toptoons / 2)
}

function compare-median($toons){
    [int]$topavg = 0
    $topvalues = $playerdata.units.data | where {$_.combat_type -ne "2"} | select power | sort power -desc | select -first $toptoons
    foreach ($toon in $topvalues){$topavg = $topavg + $toon.power -as [int]}
    $topmedian = $topavg / $topvalues.Count
    $midtoon = $toptoons/2
    $midval = $topvalues.power[$midtoon]
    $returnarray = @("$topmedian", "$midval")
    return $returnarray
}


$playercode = read-host "enter your playercode (849568558)"
if ($null -eq $playercode){
    $playercode = 849568558
}
$uri = "https://swgoh.gg/api/player/$playercode/"


$toptoons = Read-Host -prompt "Please enter as a number the number of top units you'd like to see (30) "
if ($null -eq $toptoons){
    $toptoons = 30
}

$playerdata = irm -uri "$uri" -method get
$toons = $playerdata.units.data | where {$_.combat_type -ne "2"} | select name, power | sort power -desc | select -first $toptoons

$optmsg = @('Enter 1 to see a grid of your top toons
Enter 2 to see the average power of your top toons
Enter 3 to see the toons below the top average
Enter 4 to see the average of your top toons compared to your middle top toon
Option: ')

$opt = read-host -prompt $optmsg
switch($opt){
    1 { show-toptoons $toons | out-gridview }
    2 { show-toptoonsaverage $toons }
    3 { show-subpar $toons | Out-GridView }
    4 { compare-median $toons }
}




<# code playground:

$first5 = for ($i = 0; $i -le 5; $i++){
    $playerdata.units.data.power[$i]
}
foreach ($val in $first5){
    $first5val += $val
}

#>
