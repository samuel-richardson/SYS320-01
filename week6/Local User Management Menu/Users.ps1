

<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for enabled users
****************************** #>
function getEnabledUsers(){

  $enabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "True" } | Select-Object Name, SID
  return $enabledUsers

}



<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for not enabled users
****************************** #>
function getNotEnabledUsers(){

  $notEnabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "False" } | Select-Object Name, SID
  return $notEnabledUsers

}




<# ******************************
# Create a function that adds a user
****************************** #>
function createAUser($name, $password){

    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
    $plainpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

    if (-not (checkPassword $plainpassword)){
    Write-Host "Password does not meet requirments."
    return;
    }

    if (checkUser $name){
    Write-Host "User already exists."
    return;
    }

    

   $params = @{
     Name = $name
     Password = $password
   }

   $newUser = New-LocalUser @params
   Write-Host "User: $name is created." | Out-String


   # ***** Policies ******

   # User should be forced to change password
   Set-LocalUser $newUser -PasswordNeverExpires $false

   # First time created users should be disabled
   Disable-LocalUser $newUser

}



function removeAUser($name){

    if (-not (checkUser $name)){
    Write-Host "User does not exist."
    return;
    }
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Remove-LocalUser $userToBeDeleted
   Write-Host "User: $name Removed." | Out-String
}



function disableAUser($name){

    if (-not (checkUser $name)){
    Write-Host "User does not exist."
    return;
    }
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Disable-LocalUser $userToBeDeleted
   
}


function enableAUser($name){

    if (-not (checkUser $name)){
    Write-Host "User does not exist."
    return;
    }
   
   $userToBeEnabled = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Enable-LocalUser $userToBeEnabled
   
}

function checkUser($name){
if (Get-LocalUser -Name $name -ErrorAction SilentlyContinue){
return $true
}
return $false
}

function checkPassword($password){
if ($password.length -ge 6){
$regex = [regex] "(?=.*\d)(?=.*[aA-zZ])(?=.*\W).*"
$results = $regex.Matches($password)
if ($results.value -ilike $password){ return $true}
}
return $false
}