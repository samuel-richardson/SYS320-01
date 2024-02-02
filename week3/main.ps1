. (Join-Path $PSScriptRoot ./eventLofFunctions.ps1)

clear
# get Login and Logoffs from the last 15 days
$loginoutsTable = getloginouts 15
$loginoutsTable

#Get Shut Downs and Startups from the last 25 days
$shutdownsTable = getshutdownstart 25
$shutdownsTable