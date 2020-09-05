#!/usr/bin/bash

 #CFBurl="https://store.channelfireball.com/catalog/magic_sealed_product-booster_boxes/100"
 export CFB_URL="https://store.channelfireball.com/catalog/magic_sealed_product-booster_boxes/100?filter_by_stock=out-of-stock%3Ffilter_by_stock%3Din-stock&page=PAGENUM&sort_by_price=0"
OUTFILE="CFB-"$(date +'%Y%m%d')

cat cfb-boxes.html|grep "add-to-cart-form"|sed 's/^.*data-name.//;s/data-category.*//'|sed 's/ Booster Box.*data-price=/,/' | \
	 sed 's/ Pack Display.*data-price=/,/;s/ Booster Box//' > cfb-boxes-today.txt

cat /dev/null > ${OUTFILE}

for PGNO in `seq 1 6` 
do
	URL=`echo ${CFB_URL}|sed "s/PAGENUM/${PGNO}/"`
	curl ${URL} > /tmp/prices1
	cat /tmp/prices1|grep -i "data-price=" /tmp/prices1|sed 's/.*data-name=.//;s/".*data-price=../,/;s/".*//;s/^/"/;s/,/",/;s/ Booster Box//' > /tmp/prices2
        cat /tmp/prices2|uniq|sed 's/"//g' >> ${OUTFILE}

# Read file line by line to get out of stock stuff
    cat /tmp/prices1 |grep 'itemprop="name\|^                    \$\|Out of stock\.'|sed 's/.*Out of stock.*/OOS/;s/.*title=./SET=/; s/".*//;s/                    //; s/^\$\([0-9]*\),/\$\1/; s/ Booster Box//' > /tmp/prices3
    SET_NAME=""
    while IFS= read -r line
	do
  	    TESTSET=$(echo $line|grep SET=)
  	    TESTPRICE=$(echo $line|grep '\$')
  	    if [ -n "${TESTSET}" ]; then
                SET_NAME=`echo $line|sed 's/SET=//'`
            fi
        if [ -n "${TESTPRICE}" ]; then
            SET_PRICE=`echo $line|sed 's/^.//'`
            printf "${SET_NAME},${SET_PRICE}\n" >> ${OUTFILE}
            printf "${SET_NAME},${SET_PRICE}\n"
        fi
    done < /tmp/prices3
done

sort -o ${OUTFILE} ${OUTFILE}
