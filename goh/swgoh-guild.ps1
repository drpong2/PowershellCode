
<# swgoh.gg guild check

v. 1.2

author: Marsa Ruwes

#>
<#
function show-toptoons($toons){
    #return $toons
    foreach ($val in $toons){
        $topvaluesum += $val.power
    }
    return $topvaluesum
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
    foreach ($toon in $toons){[int]$topavg += $toon.power}
    $topavg = $topavg / $toons.Count
    $topvalues = $playerdata.units.data | where {$_.combat_type -ne "2"} | select power | sort power -desc
    $midtoon = $toptoons/2
    $midval = $topvalues.power[$midtoon]
    $returnarray = @("$topavg", "$midval")
    return $returnarray
}
#>

<#$keytoonstally = [pscustomobject] @(
)
#>

$members = [pscustomobject] @(
        )
$playercode = import-csv C:\github\goh\members.csv

    <#}

    if (!$playercode){
        $playercode = 849568558
    }
    #>
    #$i = 1
foreach($player in $playercode){
    $allycode = $player.code
    $name = $player.username
    $uri = "https://swgoh.gg/api/player/$allycode/"

    $tgp = [System.Collections.ArrayList]@()
    $sgp = [System.Collections.ArrayList]@()
    $totalgp = [System.Collections.ArrayList]@()

    $playerdata = irm -uri $uri -method get

    $toons = $playerdata.units.data | where {$_.combat_type -ne "2"} | select name, power | sort power -desc
    foreach($toon in $toons){
        $tgp.add($toon.power)
    }
    $tgpsum = $tgp | Measure-Object -Sum
    $ships = $playerdata.units.data | where {$_.combat_type -eq "2"} | select name, power, rarity | sort power -desc # | select -first $toptoons
    #combat type 2 is ships

    <#use arraylists instead ~ LightofSeven#8184
    $sgp = [System.Collections.ArrayList]@() - $sgp defined on line 65, also fix $gp on line 72 (defined on line 64)
    $sgp.add($ship.power)
    $sgp | measure-object -sum

    #>
    foreach($ship in $ships){
        $sgp.add($ship.power)
    }
    $sgpsum = $sgp | Measure-Object -Sum
    $totalgp.add($tgpsum)
    $totalgp.add($sgpsum)
    $playerstats = [pscustomobject] @{
            name = $name
            toonGP = $tgpsum
            shipGP = $sgpsum
            totalGP = $totalGP
    }
    <#
    $keytoons = [pscustomobject] @{

    }
    #>
    <#
GAS
Malak
 HT
Grievous
GBA
 Negotiator
S(vulture droid)
S(hyena bomber)
S(Y-wing)
#>


    $members += $playerstats
}
$members | select name, @{n='Toon/Ship GP';e={$_.totalGP.sum}}, @{n='total GP';e={$_.toongp.sum + $_.shipgp.sum}}


<#
$optmsg = @('Enter 1 to see a grid of your top toons
Enter 2 to see the average power of your top toons
Enter 3 to see the toons below the top average
Enter 4 to see the average of your top toons compared to your middle top toon
Option: ')

$opt = read-host -prompt $optmsg

switch($opt){
    1 { show-toptoons $toons <#| out-gridview # > }
    2 { show-toptoonsaverage $toons }
    3 { show-subpar $toons | Out-GridView }
    4 { compare-median $toons }
}

#>