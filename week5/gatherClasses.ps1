function gatherClasses(){
$page = Invoke-WebRequest -Uri "http://localhost/courses.html"
$trs=$page.parsedhtml.body.getElementsByTagName("tr")

#$trs | Get-Member -MemberType Method
$FullTable = @()
for ($i=1; $i -lt $trs.length; $i++){
$tds = $trs[$i].getElementsByTagName("td")


$Times = $tds[5].innerText.split("-")

$FullTable += [pscustomobject]@{
"Class Code" = $tds[0].innerText;
"Title" = $tds[1].innerText;
"Days" = $tds[4].innerText;
"Time Start" = $Times[0];
"Time End" = $Times[1];
"Instructor" = $tds[6].innertext;
"Location" = $tds[9].innertext;
}
}
return $FullTable
}

function daysTranslator($FullTable){
for ($i=0; $i -lt $FullTable.length; $i++){

$Days = @()

if($FullTable[$i].Days -ilike "M*"){ $Days += "Monday"}

if($FullTable[$i].Days -ilike "*T[TWF]*"){ $Days += "Tuesday"}
ElseIf($FullTable[$i].Days -ilike "T"){ $Days += "Tuesday"}

if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday"}

if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday"}

if($FullTable[$i].Days -ilike "*F*"){ $Days += "Friday"}

$FullTable[$i].Days = $Days

}
Return $FullTable
}