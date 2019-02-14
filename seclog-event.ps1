$date = (get-date).adddays(-1)
$logins = get-eventlog -logname security -instanceid 4624 -after $date
$count = $logins.count

for ($i = 0; $i -le $count; $i++){
    if ($logins.message[$i] -like "*Logon Type:`t`t3*"){
        $logins.message[$i]
        }
}
