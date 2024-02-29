. (Join-Path $PSScriptRoot Events.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome`n"
$Prompt += "5 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    if ((-not ($choice -match "^[1-5]$"))){Write-Host "Not a valid input."; continue;}

    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    if($choice -eq 1){$apacheLogs = ApacheLogs1; write-host ($apacheLogs | Format-Table | Out-String)}

    elseif($choice -eq 2){$failedLogins = getFailedLogins; write-host ($failedLogins[-10..-1] | Format-Table | Out-String)}

    elseif($choice -eq 3){

        $failedLogins = getFailedLogins
       
        Write-Host ($failedLogins | Group-Object User | where-object {$_.count -ge 10} | select count, name | Format-Table | Out-String)
    }
    elseif($choice -eq 4){startChrome}

}