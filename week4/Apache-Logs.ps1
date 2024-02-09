function getApacheLogs($page,$code,$browser){

$foundLogs = Get-Content C:\xampp\apache\logs\access.log | Select-String -Pattern "$page" | Select-String -Pattern "$code" | Select-String -Pattern "$browser"

$regex = [regex] "([0-9]{1,3}\.){3}[0-9]{1,3}"

$ipsUnorganized = $regex.Matches($foundLogs)

$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
$ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value;}
}

$ipsoftens = $ips | where-object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group-Object IP | select Name, Count
return $counts
}
