 #!/usr/bin/bash

 OUTFILE="CK-prices-"$(date +'%Y%m%d')
 cat /dev/null > $OUTFILE
 
 echo $PRICE |sed 's/.*\$//;s/<.*//'
 
 
  IFS="";while read EXPAN 
  do 
    EXPAN_URL=$(echo "https://www.cardkingdom.com/mtg-sealed/${EXPAN}-booster-box"|tr '[:upper:]' '[:lower:]')
	if [ "${EXPAN}" == "Mystery" ]; then
	  EXPAN_URL="https://www.cardkingdom.com/mtg-sealed/mystery-booster-booster-box-retail-edition"
	fi
	if [ "${EXPAN}" == "time-spiral-remastered" ]; then
	  EXPAN_URL="https://www.cardkingdom.com/mtg-sealed/${EXPAN}-draft-booster-box"
	fi
	if [ "${EXPAN}" == "Theros-Beyond-Death" ]; then
	  EXPAN_URL="https://www.cardkingdom.com/mtg-sealed/${EXPAN}-draft-booster-box"
	fi
	if [ "${EXPAN}" == "Throne-of-Eldraine" ]; then
	  EXPAN_URL="https://www.cardkingdom.com/mtg-sealed/${EXPAN}-draft-booster-box"
	fi
	if [ "${EXPAN}" == "Ikoria-Lair-of-Behemoths" ]; then
	  EXPAN_URL="https://www.cardkingdom.com/mtg-sealed/${EXPAN}-draft-booster-box"
	fi
	# curl ${EXPAN_URL} > /tmp/CK1.html
	PRICE_LN=`curl $EXPAN_URL|grep itemPrice`
	PRICE=$(echo ${PRICE_LN}|sed 's/.*\$//;s/<.*//;s/,//')
    
	printf "Exp: ${EXPAN},Price: ${PRICE}\n"
	printf "${EXPAN},${PRICE}\n">> $OUTFILE
	
  done < ../TCG/expansion-list-unsorted


