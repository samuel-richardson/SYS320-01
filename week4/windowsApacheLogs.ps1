clear

# 3 List all fo the apache logs of xampp
#Get-Content C:\xampp\apache\logs\access.log

#4
#Get-Content C:\xampp\apache\logs\access.log -tail 5

#5
#Get-Content C:\xampp\apache\logs\access.log | Select-String -Pattern '404','400'

#6
#Get-Content C:\xampp\apache\logs\access.log | Select-String -NotMatch '200'

#7
#$A = Get-Childitem -Path C:\xampp\apache\logs\*.log | Select-String -Pattern 'error'
#$A[-5..-1]
#8
$notFounds = Get-Content C:\xampp\apache\logs\access.log | Select-String -Pattern '404'
$notFounds
$regex = [regex] "([0-9]{1,3}\.){3}[0-9]{1,3}"

$ipsUnorganized = $regex.Matches($notFounds)

$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
$ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value;}
}

$ipsoftens = $ips | where-object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group-Object IP
$counts | Select-Object Count, Name