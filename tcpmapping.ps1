<#tcpmapping#>

$tcpopen = get-nettcpconnection | select owningprocess,localport,remoteaddress,remoteport |where {$_.remoteport -ne 0}|where {$_.OwningProcess -ne 0}
$processes = get-process | select id,processname
$proc_dict = @{}
$processes | foreach{$proc_dict[[uint32]$_.id] = $_.processname}
#Gotta cast proc_dict as a uint32 so that I can do a lookup using $tcp.owningprocess

$objlist = @()
foreach($tcp in $tcpopen){
$obj = [pscustomobject] @{
    remoteaddress = $tcp.remoteaddress
    remoteport = $tcp.remoteport
    procid = $tcp.owningprocess
    processname = $proc_dict[$tcp.owningprocess]
    }
    $objlist += $obj
}
