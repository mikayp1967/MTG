#!/usr/bin/bash
#
# 24/3/21
# Allow entry of an expansion pattern for search
#

cat /dev/null > /tmp/CM-explist
PARAM1=$1
case ${PARAM1} in
        "brief")
                cat expansion-list-brief > /tmp/CM-explist
		NUM_LINES=600
                ;;
        "")
                cat expansion-list-unsorted > /tmp/CM-explist
		NUM_LINES=6
                ;;
        *)
	        ALL_PARAMS=$@
	        PARAM1=$(echo ${ALL_PARAMS}|sed 's/^ //;s/  *$//'|sed 's/  */\\|/g')
		printf "Looking for pattern ${PARAM1}\n"
                grep -i ${PARAM1} expansion-list-unsorted > /tmp/CM-explist
		NUM_LINES=600
                ;;
esac


while read expansion ;
 do printf "${expansion}\n"
 grep "^${expansion}," data/CM-prices-*|sed 's/^data.//'|sed 's/\(CM-.......\)\(......\)\(.*\)/\2,\1\2\3/'|sort -t, -u -k1,1 |sed 's/^.......//' |sed "s/CM-prices-/     /;s/\:${expansion}\,/ - /"> /tmp/cm-file

 grep "^${expansion}," data/CM-prices-*|sed "s/data.CM-prices-/     /;s/\:${expansion}\,/ - /"|tail -3 >> /tmp/cm-file 
 cat /tmp/cm-file|sort|uniq|awk '{pri=$3} opri!=pri; {opri=pri}'|tail -${NUM_LINES}

 done  < /tmp/CM-explist
