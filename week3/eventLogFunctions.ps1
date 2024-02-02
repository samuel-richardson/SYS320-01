function getloginouts($age) {
# Get login and logoff records
$loginouts = Get-EventLog -LogName System -source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-$age)

$loginoutsTable = @()
for($i=0; $i -lt $loginouts.count; $i++){
$event = ""
if($loginouts[$i].InstanceID -eq "7001") {$event="Logon"}
if($loginouts[$i].InstanceID -eq "7002") {$event="Logoff"}

$user = $loginouts[$i].ReplacementStrings[1]
$user = Get-LocalUser -SID $user

$loginoutsTable += [pscustomobject]@{
"Time" = $loginouts[$i].TimeGenerated;
"Id" = $loginouts[$i].InstanceId;
"Event" = $event;
"User" = $user;
}

}

return $loginoutsTable
}


function getshutdownstart($age) {
# Get login and logoff records
$updowns = Get-EventLog -LogName system -Source EventLog -After (Get-Date).AddDays(-$age) |
 Where-Object {$_.EventID -match "600[5-6]"}

$updownsTable = @()
for($i=0; $i -lt $updowns.count; $i++){
$event = ""
if($updowns[$i].EventID -eq "6005") {$event="StartUp"}
if($updowns[$i].EventID -eq "6006") {$event="ShutDown"}

$USER = "System"

$updownsTable += [pscustomobject]@{
"Time" = $updowns[$i].TimeGenerated;
"Id" = $updowns[$i].EventID;
"Event" = $event;
"User" = $USER;
}

}

return $updownstable
}