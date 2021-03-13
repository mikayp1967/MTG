#!/usr/bin/bash

PARAM1=$1
NUM_HIST=6
ALL_MONTHS=$(ls -1tr data/TCG-FAB-prices*|cut -c21-26|sort|uniq)

case ${PARAM1} in
        "1st")
                EXP="expansion-list-brief"
                ESET="1st"
                NUM_HIST=1000
                ;;
        *)
                EXP="expansion-list-unsorted"
                ESET="Unlimited"
                ;;
esac

EXP="expansion-list-fab"
NUM_HIST=1000


while read expansion ;
 do printf "${expansion}\n"

  cat /dev/null > /tmp/tcg-file-${expansion}
  echo ${ALL_MONTHS}| \
  while read MONTH; do
    MONTH_FILE=$(grep -l ${expansion} data/TCG-FAB-prices-${MONTH}*|head -1) 
    if [ "${MONTH_FILE}" != "" ] ;then
    	MFD=$(echo ${MONTH_FILE}|sed 's/.*-/     /')
	MFP=$(grep  "^${expansion}-${ESET}," ${MONTH_FILE}|sed "s/.*\,//")
	if [ "${MFP}" != "" ]; then
	  printf "${MFD} - ${MFP}\n" >> /tmp/tcg-file-${expansion}
	fi
    fi
  done

 grep "^${expansion}-${ESET}," data/TCG-FAB-prices-*|sed "s/.*TCG-FAB-prices-/     /;s/\:${expansion}-${ESET}\,/ - /"|tail -2 >> /tmp/tcg-file-${expansion}
 cat /tmp/tcg-file-${expansion}|sort|uniq|tail -${NUM_HIST}

 done  < ${EXP}
