function df {
    # Disk space
    $DisksInformation = Get-CIMInstance -class "Win32_LogicalDisk" -namespace "root\CIMV2" -computername localhost
    [System.Collections.ArrayList]$DisplayObject = @()
    foreach ($Item in $DisksInformation) {
        $CollectionObject = [PSCustomObject]@{
            'ID'                =    $Item.DeviceID 
            'Network Path'      =    $Item.ProviderName
            'Description'       =    $Item.Description 
            'File System'       =    $Item.FileSystem 
            'Total Space (GB)'        =    [math]::Round(($Item.Size / 1GB),0).ToString() 
            'Free Space (GB)'        =    [math]::Round(($Item.FreeSpace / 1GB),0).ToString()
        }
        $DisplayObject.Add($CollectionObject) > $null
    }
    $DisplayObject | Format-Table
}

