. (Join-Path $PSScriptRoot String-Helper.ps1)

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
$tableRecords = ($tableRecords | Where-Object {$_.IP -ilike "10.*"})
return $tableRecords[-10..-1]
}

function getFailedLogins(){
  
  $failedlogins = Get-EventLog security | Where { $_.InstanceID -eq "4625" }

  $failedloginsTable = @()
  for($i=0; $i -lt $failedlogins.Count; $i++){

    $account=""
    $domain="" 

    $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
    $usr = $usrlines[1].Split(":")[1].trim()

    $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
    $dmn = $dmnlines[1].Split(":")[1].trim()

    $user = $dmn+"\"+$usr;

    $failedloginsTable += [pscustomobject]@{"Time" = $failedlogins[$i].TimeGenerated; `
                                       "Id" = $failedlogins[$i].InstanceId; `
                                    "Event" = "Failed"; `
                                     "User" = $user;
                                     }

    }

    return ($failedloginsTable | sort Time)
} # End of function getFailedLogins

function startChrome(){
    if ((Get-Process -Name "*chrome*") -ne $null){
        Write-Host "Chrome already Running"
    }
    else{
    Start-Process "C:\Program Files\Google\Chrome\Application\Chrome.exe" -ArgumentList '"https://champlain.edu"'
    }
}
