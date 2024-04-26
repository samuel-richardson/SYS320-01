#!/bin/bash

logFile=$1
ioc=$2


cat "$logFile" | grep -i -f "$ioc" | cut -d' ' -f1,4,7 | tr -d '[' > report.txt
