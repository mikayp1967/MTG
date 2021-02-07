 #!/usr/bin/bash

 OUTFILE="data/TCG-prices-"$(date +'%Y%m%d')
 cat /dev/null > $OUTFILE
 
 
  IFS="";while read EXPAN 
  do 
    EXPAN_URL=$(echo "https://shop.tcgplayer.com/magic/${EXPAN}/${EXPAN}-booster-box"|tr '[:upper:]' '[:lower:]')
	case ${EXPAN} in
		"Mystery")
			EXPAN_URL="https://shop.tcgplayer.com/magic/mystery-booster-retail-exclusives/mystery-booster-booster-box-retail-exclusive"
			;;
		"Zendikar-Rising-Set")
			EXPAN_URL="https://shop.tcgplayer.com/magic/zendikar-rising/zendikar-rising-set-booster-display"
			;;
		"Zendikar-Rising-Draft")
			EXPAN_URL="https://shop.tcgplayer.com/magic/zendikar-rising/zendikar-rising-draft-booster-box"
		;;
		"Core-2021")
			EXPAN_URL="https://shop.tcgplayer.com/magic/core-set-2021/core-set-2021-booster-box"
		;;
		"Core-2020")
			EXPAN_URL="https://shop.tcgplayer.com/magic/core-set-2021/core-set-2020-booster-box"
		;;
		"Core-2019")
			EXPAN_URL="https://shop.tcgplayer.com/magic/core-set-2021/core-set-2019-booster-box"
		;;
	esac

	curl -k ${EXPAN_URL} > /tmp/TCG1.html

	PRICE=$(cat  /tmp/TCG1.html|grep "price-point__data"|head -1|sed 's/.*\$//;s/<.*//;s/,//')
    
	printf "Exp: ${EXPAN},Price: ${PRICE}\n"
	printf "${EXPAN},${PRICE}\n">> $OUTFILE
	
  done < expansion-list-unsorted


