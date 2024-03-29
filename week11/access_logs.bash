#!/bin/bash


file="/var/log/apache2/access.log"

#cat $file | grep "page2.html" | cut -d ' ' -f 1,7 | tr -d '/'

function pageCount(){
pagesAccessed=$(cat $file | cut -d ' ' -f 7 | uniq -c | sort -u)
}


function countingCurlAccess(){
curled=$(cat $file | grep 'curl' | cut -d ' ' -f 1,12 | uniq -c | sort -u)
}

countingCurlAccess
echo $curled
