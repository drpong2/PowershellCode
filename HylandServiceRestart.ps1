restart-service "Hyland Sca"
sleep -seconds 5
restart-service "Hyland Sch"
$finishtime = date
echo "completed $finishtime" >> C:\scripts\restartstatus.txt