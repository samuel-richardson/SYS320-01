clear
$scraped_page = Invoke-WebRequest -Uri "http://localhost/ToBeScraped.html"



#$scraped_page | get-member

#$scraped_page.links.href.count

#$scraped_page.links

#$scraped_page.links | select outertext,href

#$h2s=$scraped_page.parsedhtml.body.getElementsByTagName("h2") | select outerText

#$h2s

$divs1=$scraped_page.parsedhtml.body.getElementsByTagName("div") | where {
$_.getAttributeNode("class").value -ilike "div-1"} | select innerText

$divs1