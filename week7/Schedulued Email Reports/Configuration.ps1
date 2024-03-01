
function notvalid($days, $etime){
    if (-not ($days -match "^[0-9]{1,3}$")){
        return $true
        }

    if (-not ($etime -match "(^([1-9]{1}|11|12):[0-5][0-9]) (AM|PM)$" )){
        return $true
    }

}

function showConfiguration(){
    $conf = Get-Content $PSScriptRoot/configuration.txt
    $confContent = @() 
    $confContent += [pscustomobject]@{"Days" = $conf[0]; "ExecutionTime" = $conf[1]}
    return $confContent
}

function changeConfiguration(){

    $days = Read-Host -Prompt "Enter the number of days for which logs will be obtained: "

    
    $etime = Read-Host -Prompt "Enter the daily execution time(eg. 1:22 PM): "

    if((notvalid $days $etime)) {Write-Host "Not a valid input." | Out-String; return;} 

    "$days`n$etime" | Out-File -FilePath $PSScriptRoot/configuration.txt -NoNewline
}


clear

$Prompt = "Please choose your operation:`n1) Show Configuration`n2) Change Configuration`n3) Exit`n"

$operation = $true

While($operation){
    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if ((-not ($choice -match "^[1-3]$"))){Write-Host "Not a valid input."; continue;}

    if($choice -eq 3){
        exit
        $operation = $false
        }
    elseif($choice -eq 1){ 
        $conf = showConfiguration
        Write-Host ($conf | Format-Table | Out-String)
    }

    elseif($choice -eq 2){changeConfiguration}
}