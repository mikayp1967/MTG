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
 grep "^${expansion}," data/TCG-prices-*|sed "s/.*TCG-prices-/     /;s/\:${expansion}\,/ - /"|awk 'NR%4==0' > /tmp/tcg-file
 grep "^${expansion}," data/TCG-prices-*|sed "s/.*TCG-prices-/     /;s/\:${expansion}\,/ - /"|tail -2 >> /tmp/tcg-file
 cat /tmp/tcg-file|sort|uniq|tail -6
 
 done  < ${EXP}
