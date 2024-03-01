. (Join-Path $PSScriptRoot String-Helper.ps1)


function getFailedLogins($timeBack){
  
  $failedlogins = Get-EventLog security -After (Get-Date).AddDays("-"+"$timeBack") | Where { $_.InstanceID -eq "4625" }

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

function atRiskUsers($timeBack){

$failedLogins = getFailedLogins $timeBack
       
Return ($failedLogins | Group-Object User | where-object {$_.count -ge 10} | select count, name)
}