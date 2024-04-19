#!/bin/bash

curl http://10.0.17.5/IOC.html | awk '/<tr>/{getline; print}' | grep -v '<th>' | tr '<td>' ' ' | tr '</td>' ' '


