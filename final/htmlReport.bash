#!/bin/bash

report=report.html

echo "<html>" > "$report"

echo "<head><title>Indicators of Compromise</title><style> table, th, td {border: 1px solid black;}</style></head>" >> "$report"


echo "<body>" >> "$report"
echo "<p> Access logs with IOC indicators: </p>" >> "$report"
echo "<table>" >> "$report"
echo "<tr><th> IP </th> <th> Date </th> <th> IOC </th></tr>" >> "$report"

while read ip date ioc xtra
do

echo "<tr> <td>$ip</td> <td>$date</td> <td>$ioc</td> </tr>" >> "$report"

done < "report.txt"


echo "</table>" >> "$report"
echo "</body>" >> "$report"
echo "</html>" >> "$report"

cp "$report" /var/www/html/"$report"
