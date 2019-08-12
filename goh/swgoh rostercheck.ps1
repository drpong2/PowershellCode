$memberlist = import-csv .\members.csv -Delimiter " " -header "number", "name", "allycode"

foreach ($member in $memberlist){
    $playercode = $member.allycode.replace("-","")
}

$playercode = read-host "enter your playercode: "
$uri = "https://swgoh.gg/api/player/849568558/"

#$toptoons = Read-Host -prompt "Please enter as a number the number of top units you'd like to see: "


$playerdata = irm -uri "$uri" -method get


$toons | where {$_.categories -contains "geonosian"}

#$playerdata.units.data | where {$_.combat_type -ne "2"} | select name, power | sort power -desc | select -first $toptoons | out-gridview