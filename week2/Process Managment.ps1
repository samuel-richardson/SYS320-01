clear
#Get-Process -Name "C*"

#Get-Process -Name * | where-object {$_.path -notlike "*system32*"} | Select ProcessName, Path

#Get-Service -Name * | where-object {$_.status -ilike "Stopped" }

#4
if ((Get-Process -Name "*chrome*") -ne $null){
    Get-Process -Name "*chrome*" | Stop-Process
}
else{
Start-Process "C:\Program Files\Google\Chrome\Application\Chrome.exe" -ArgumentList '"https://champlain.edu"'
}