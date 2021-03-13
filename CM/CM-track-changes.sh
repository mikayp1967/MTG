#!/usr/bin/bash

PARAM1=$1
case ${PARAM1} in
        "brief")
                EXP="expansion-list-brief"
		NUM_LINES=600
                ;;
        *)
                EXP="expansion-list-unsorted"
		NUM_LINES=6
                ;;
esac

printf "EXP-LIST: ${EXP}\n\n"

while read expansion ;
 do printf "${expansion}\n"
 grep "^${expansion}," data/CM-prices-*|sed 's/^data.//'|sed 's/\(CM-.......\)\(......\)\(.*\)/\2,\1\2\3/'|sort -t, -u -k1,1 |sed 's/^.......//' |sed "s/CM-prices-/     /;s/\:${expansion}\,/ - /"> /tmp/cm-file

 #grep "^${expansion}," data/CM-prices-*|sed "s/data.CM-prices-/     /;s/\:${expansion}\,/ - /"|awk 'NR%4==0' > /tmp/cm-file
 grep "^${expansion}," data/CM-prices-*|sed "s/data.CM-prices-/     /;s/\:${expansion}\,/ - /"|tail -2 >> /tmp/cm-file 
 cat /tmp/cm-file|sort|uniq|awk '{pri=$3} opri!=pri; {opri=pri}'|tail -${NUM_LINES}

 done  < ${EXP}
