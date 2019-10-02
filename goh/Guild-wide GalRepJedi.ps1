$uri = "https://swgoh.gg/api/guild/13387"
$toons = irm -uri https://swgoh.gg/api/characters
$grjedi = $toons | where {$_.categories -contains "jedi" -and $_.categories -contains "Galactic Republic"} | select name

$guild = irm -uri $uri -method get

$playerlist = $guild.players.data | select ally_code, name

foreach ($player in $playerlist){
    $playercode = $player.ally_code
    $uri = "https://swgoh.gg/api/player/$playercode"
    $apiget = irm -uri $uri -method get
    $playertoon = $apiget.units.data | where {$_.name <#-in $grjedi#> -eq "Kit Fisto"}
    <#$playertoon = $apiget.units.data#>
    $playergrjedi = $playertoon <#| where {$_.name -in $grjedi.name -eq "Kit Fisto"} #>| select <#name, #>rarity, gear_level
    $player.name >> C:\scripts\kitfisto.txt; $playergrjedi >> C:\scripts\kitfisto.txt
}

