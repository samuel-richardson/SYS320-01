function Challenge2(){
$apacheAccessLogs = Get-Content $PSScriptRoot/access.log

$tableLogs = @()

for ($i=0; $i -lt $($apacheAccessLogs.count); $i++){

$words = $apacheAccessLogs[$i].Split(" ")

$tableLogs += [pscustomobject]@{
"IP" = $words[0];
"Time" = $words[3].Trim('[');
"Method" = $words[5].Trim('"');
"Page" = $words[6];
"Protocol" = $words[7];
"Response" = $words[8];
"Referrer" = $words[10];
}

}
return $tableLogs
}
