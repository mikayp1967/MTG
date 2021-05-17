#!/usr/bin/bash

PARAM1=$1
NUM_HIST=6
IFS=' ';ALL_MONTHS=$(ls -1tr data/TCG-FAB-prices*|cut -c21-26|sort|uniq)

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
RELS="1st Unlimited"


while read expansion ;
 do 
 for ESET in ${RELS}
   do printf "${expansion} ${ESET}\n"
   cat /dev/null > /tmp/tcg-file-${expansion}-${ESET}

    echo ${ALL_MONTHS}| \
    while read MONTH; do
      MONTH_FILE=$(grep -l ${expansion} data/TCG-FAB-prices-${MONTH}*|head -1) 
      if [ "${MONTH_FILE}" != "" ] ;then
    	  MFD=$(echo ${MONTH_FILE}|sed 's/.*-/     /')
	  MFP=$(grep  "^${expansion}-${ESET}," ${MONTH_FILE}|sed "s/.*\,//")
	  if [ "${MFP}" != "" ]; then
	    printf "${MFD} - ${MFP}\n" >> /tmp/tcg-file-${expansion}-${ESET}
	  fi
      fi
    done
    #printf "\n"

    grep "^${expansion}-${ESET}," data/TCG-FAB-prices-*|sed "s/.*TCG-FAB-prices-/     /;s/\:${expansion}-${ESET}\,/ - /"|tail -2 >> /tmp/tcg-file-${expansion}-${ESET}
    cat /tmp/tcg-file-${expansion}-${ESET}|sort|uniq|tail -${NUM_HIST}
  done

 done  < ${EXP}
