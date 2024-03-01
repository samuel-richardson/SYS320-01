
function sendAlertEmail($Body){
$appPassword = "appPassword"

$From = "samuel.richardson@mymail.champlain.edu"
$To = "samuel.richardson@mymail.champlain.edu"
$Subject = "Suspicous Activity"

$Password =  $appPassword | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" -port 587 -UseSsl -Credential $Credential
}