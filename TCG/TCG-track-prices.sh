#!/usr/bin/bash

PARAM1=$1
NUM_HIST=6
ALL_MONTHS=$(ls -1tr data/TCG-prices*|cut -c17-22|sort|uniq)

case ${PARAM1} in
        "brief")
                EXP="expansion-list-brief"
                NUM_HIST=1000
                ;;
        *)
                EXP="expansion-list-unsorted"
                ;;
esac

printf "EXP-LIST: ${EXP}\n\n"


while read expansion ;
 do printf "${expansion}\n"

  cat /dev/null > /tmp/tcg-file-${expansion}
  echo ${ALL_MONTHS}| \
  while read MONTH; do
    MONTH_FILE=$(grep -l ${expansion} data/TCG-prices-${MONTH}*|head -1) 
    if [ "${MONTH_FILE}" != "" ] ;then
    	MFD=$(echo ${MONTH_FILE}|sed 's/.*-/     /')
	MFP=$(grep "^${expansion}," ${MONTH_FILE}|sed "s/.*\,//")
	if [ "${MFP}" != "" ]; then
	  printf "${MFD} - ${MFP}\n" >> /tmp/tcg-file-${expansion}
	fi
    fi
  done

 grep "^${expansion}," data/TCG-prices-*|sed "s/.*TCG-prices-/     /;s/\:${expansion}\,/ - /"|tail -2 >> /tmp/tcg-file-${expansion}
 cat /tmp/tcg-file-${expansion}|sort|uniq|tail -${NUM_HIST}

 done  < ${EXP}
