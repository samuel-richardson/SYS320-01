clear
#Get IPV4 Address from Ethernet0 Interface
#(Get-NetIPaddress -AddressFamily IPV4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).IPAddress

#Get IPv4 PrefixLength from Ethernet0 Interface
#(Get-NetIPaddress -AddressFamily IPV4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).PrefixLength

#3 and 4
#Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_*" } | Sort-Object

#5 and 6
#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter DHCPEnabled=$true |
# select DHCPServer | Format-Table -HideTableHeaders

#7
#(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet0"}).ServerAddresses[0]

#8

<#cd $PSScriptRoot
$files=(Get-ChildItem)
for ($j=0; $j -le $files.Count; $j++){
    
    if ($files[$j].Name -ilike "*.ps1"){
        Write-Host $files[$j].Name
    }
}#>

#9
<#$folderpath="$PSScriptRoot\outfolder"
if (Test-Path $folderpath){
    Write-Host "Folder Already Exists"
}
else{
New-Item -ItemType Directory -Path $folderpath
}#>

#10
<#cd $PSScriptRoot
$files=(Get-ChildItem -Filter "*.ps1")
$folderpath="$PSScriptRoot\outfolder"
$filePath= Join-Path $folderpath "out.csv"
$files | select Name | Export-Csv -Path $filePath#>

#11
<#$files=(Get-ChildItem -Recurse -File)
$files | Rename-Item -NewName {$_.Name -replace '.csv', '.log'}
Get-ChildItem -Recurse -File#>
