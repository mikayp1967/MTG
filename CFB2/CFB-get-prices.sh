  #!/usr/bin/bash

 OUTFILE="CFB-prices-"$(date +'%Y%m%d')
 cat /dev/null > $OUTFILE
 

 
  IFS="";while read EXPAN 
  do 
    EXPAN_URL=$(echo "https://shop.channelfireball.com/collections/booster-boxes/products/${EXPAN}-booster-box")
	case ${EXPAN} in
		"Mystery")
			EXPAN_URL="https://shop.channelfireball.com/collections/booster-boxes/products/mystery-booster-box-retail-exclusive"
			;;
		"ZZendikar-Rising-Set")
			EXPAN_URL="https://shop.tcgplayer.com/magic/zendikar-rising/zendikar-rising-set-booster-display"
			;;
		"ZZendikar-Rising-Draft")
			EXPAN_URL="https://shop.tcgplayer.com/magic/zendikar-rising/zendikar-rising-draft-booster-box"
		;;
		"ZCore-2021")
			EXPAN_URL="https://shop.tcgplayer.com/magic/core-set-2021/core-set-2021-booster-box"
		;;
		"ZCore-2020")
			EXPAN_URL="https://shop.tcgplayer.com/magic/core-set-2021/core-set-2020-booster-box"
		;;
		"ZCore-2019")
			EXPAN_URL="https://shop.tcgplayer.com/magic/core-set-2021/core-set-2019-booster-box"
		;;
	esac

	curl -k ${EXPAN_URL} > /tmp/TCG1.html

	PRICE=$(cat  /tmp/TCG1.html|grep -i '"price":' |grep currency|head -1|sed 's/.*price...//;s/".*//' )
    
	printf "Exp: ${EXPAN},Price: ${PRICE}\n"
	printf "${EXPAN},${PRICE}\n">> $OUTFILE
	
  done < expansion-list-unsorted


