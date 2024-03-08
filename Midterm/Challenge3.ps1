. (Join-Path $PSScriptRoot ./Challenge1.ps1)
. (Join-Path $PSScriptRoot ./Challenge2.ps1)

function challenge3($logs, $indicators){
$indicators = $indicators.pattern

$malLogs = @()

for ($i = 0; $i -lt $indicators.count; $i++){
$malLogs += $logs | Where-Object {$_.Page -match $indicators[$i]}
}

return $malLogs | Sort-Object -Property Time,Page -Unique
}

$table = Challenge3 (Challenge2) (Challenge1)

$table | Format-Table