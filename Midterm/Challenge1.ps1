
#Challenge 1

function challenge1() {
$response = Invoke-WebRequest -Uri http://10.0.17.5/IOC.html

$trs=$response.ParsedHtml.body.getElementsByTagName("tr")

$FullTable = @()

for ($i=1; $i -lt $trs.length; $i++){
$tds = $trs[$i].getElementsByTagName("td")

$FullTable += [pscustomobject]@{
"Pattern" = $tds[0].innerText;
"Explaination" = $tds[1].innerText;
}

}
return $FullTable

}