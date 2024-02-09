function ApacheLogs1() {
$logsNotformated = Get-Content C:\xampp\apache\logs\access.log
$tableRecords = @()

for ($i=0; $i -lt $($logsNotformated.count); $i++) {
$words = $logsNotformated[$i].Split(" ")


$tablerecords += [pscustomobject]@{
 "IP" = $words[0];
 "Time" = $words[3].Trim('[');
 "Method" = $words[5].Trim('"');
 "Page" = $words[6];
 "Protocol" = $words[7];
 "Response" = $words[8];
 "Referrer" = $words[10];
 "Client" = $words[11..($words.count)];}
}
return $tableRecords | Where-Object {$_.IP -ilike "10.*"}
}