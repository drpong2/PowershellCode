$From = "drpong2@gmail.com"
$To = "mr.s.martin@aol.com"
$Cc = "drpong2@gmail.com"
#$Attachment = "C:\temp\Some random file.txt"
$Subject = "Email Subject"
$Body = "test message"
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"
Send-MailMessage -From $From -to $To -Cc $Cc -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Credential (Get-Credential) #-Attachments $Attachment