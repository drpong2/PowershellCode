$date = (get-date).adddays(-1)
$logins = get-eventlog -logname security -instanceid 4624 -after $date
$count = $logins.count
$path = 'C:\scripts\seclogdata\'
$filename = $date.ToShortDateString()
$filename = $filename.replace('/','.')


$writepath = $path + $filename + '.log'

for ($i = 0; $i -le $count; $i++){
    if ($logins.message[$i] -like "*Logon Type:`t`t3*"){
        out-file -filepath $writepath -inputobject $logins.message[$i] -append
        }
}
