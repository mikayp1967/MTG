#!/usr/bin/bash

 OUTFILE="data/TCG-FAB-prices-"$(date +'%Y%m%d')
 cat /dev/null > $OUTFILE
 
 
  IFS="";while read EXPAN 
  do 
    EXPAN_URL=$(echo "https://shop.tcgplayer.com/flesh-and-blood-tcg/${EXPAN}/${EXPAN}-booster-box"|tr '[:upper:]' '[:lower:]')
	case ${EXPAN} in			# Left in if things change in future
		"Mystery")
			EXPAN_URL="https://shop.tcgplayer.com/magic/mystery-booster-retail-exclusives/mystery-booster-booster-box-retail-exclusive"
			;;
		"kaldheim-set")
			EXPAN_URL="https://shop.tcgplayer.com/magic/kaldheim/kaldheim-set-booster-display"
			;;
	esac

	curl -k "${EXPAN_URL}-1st-edition" > /tmp/TCG1.html
	PRICE=$(cat  /tmp/TCG1.html|grep "price-point__data"|head -1|sed 's/.*\$//;s/<.*//;s/,//')
	printf "${EXPAN}-1st,${PRICE}\n">> $OUTFILE

	curl -k "${EXPAN_URL}-unlimited-edition" > /tmp/TCG1.html
	PRICE=$(cat  /tmp/TCG1.html|grep "price-point__data"|head -1|sed 's/.*\$//;s/<.*//;s/,//')
	printf "${EXPAN}-Unlimited,${PRICE}\n">> $OUTFILE
	
  done < expansion-list-fab


