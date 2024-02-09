. (Join-Path $PSScriptRoot ./Apache-Logs.ps1)
. (Join-Path $PSScriptRoot ./ApacheLogs.ps1)

clear
$logs = getApacheLogs 'index.html' '200' 'firefox'
$logs

$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap