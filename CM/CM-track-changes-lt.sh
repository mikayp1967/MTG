#!/usr/bin/bash

PARAM1=$1
case ${PARAM1} in
        "brief")
                EXP="expansion-list-brief"
                ;;
        *)
                EXP="expansion-list-unsorted"
                ;;
esac

printf "EXP-LIST: ${EXP}\n\n"

while read expansion ;
 do printf "${expansion}\n"
 grep "^${expansion}," data/CM-prices-*|sed "s/data.CM-prices-/     /;s/\:${expansion}\,/ - /"|awk 'NR%4==0' > /tmp/cm-file
 grep "^${expansion}," data/CM-prices-*|sed "s/data.CM-prices-/     /;s/\:${expansion}\,/ - /"|tail -2 >> /tmp/cm-file 
 cat /tmp/cm-file|sort|uniq|tail -6

 done  < ${EXP}
