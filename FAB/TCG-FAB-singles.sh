#!/usr/bin/bash

 OUTFILE="data/TCG-FAB-singles-prices-"$(date +'%Y%m%d')
 cat /dev/null > $OUTFILE
 
 
  IFS="";while read CARD 
  do 
    CARD_URL=$(echo "https://shop.tcgplayer.com/flesh-and-blood-tcg/${CARD}"|tr '[:upper:]' '[:lower:]')
	case ${CARD} in			# Left in if things change in future
		"Mystery")
			CARD_URL="https://shop.tcgplayer.com/magic/mystery-booster-retail-exclusives/mystery-booster-booster-box-retail-exclusive"
			;;
		"kaldheim-set")
			CARD_URL="https://shop.tcgplayer.com/magic/kaldheim/kaldheim-set-booster-display"
			;;
	esac

	curl -s -k "${CARD_URL}" > /tmp/TCG1.html
	PRICE=$(cat  /tmp/TCG1.html|grep "price-point__data"|head -2|tail -1|sed 's/.*\$//;s/<.*//;s/,//')
	printf "${CARD}-1st,${PRICE}\n">> $OUTFILE

	tail -1 ${OUTFILE}
	
  done < singles-list-fab


