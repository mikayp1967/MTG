#!/usr/bin/bash
#

while read expansion
 do printf "${expansion}\n"
 grep -i "^${expansion}," CK-prices-*|sed "s/CK-prices-/     /;s/\:${expansion}.*\,/ - /" > /tmp/CK-prices
 cat /tmp/CK-prices|awk '{pri=$3} opri!=pri; {opri=pri}'
 done  < ../TCG/expansion-list-unsorted
 #done  < ./expansion-list-unsorted
