#!/bin/bash

fullPage=$(curl -sL "http://10.0.17.5/IOC.html")

#echo "$fullPage"

tOut=$(echo "$fullPage" | \
xmlstarlet select --template --copy-of "//html//body//table/tr")

echo $tOut | sed 's/<\/tr>/\n/g' | \
             sed -e 's/&amp;//g' | \
             sed -e 's/<tr>//g' | \
			 sed -e 's/<td[^>]*>//g' | \
	         sed -e 's/<\/td>/;/g' | \
             sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
             sed -e 's/<[/\]\{0,1\}nobr>//g' | \
			 grep -v "Pattern" | \
			 cut -d';' -f1 | \
			 sed 's/ //' | \
			 sed '/^$/d' \
			 > IOC.txt


