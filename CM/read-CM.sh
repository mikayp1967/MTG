#!/usr/bin/bash

 OUTFILE="CM-prices-"$(date +'%Y%m%d')
# copy template
  key=`cat key`
  next_url='https://www.cardmarket.com/en/Magic/Products/Booster-Boxes/Jumpstart-Booster-Box'
  next_url=$1
  cat CM-curl-template |sed "s[URL[${next_url}[;s/KEY/${key}/" > CM-curl.sh
  expansion=$(echo $next_url|sed 's/.*\///;s/-Booster-Box//')
 
# Run template to get new page
  . ./CM-curl.sh

# Separate prices, strip some guff
  cat CM-raw.htm |sed 's/<div id="articleRow/\
<div id="articleRow/g'|grep articleRow |grep "this,'English'"|head -3 > CM-raw2.htm
  NUM_BOXES=$(wc -l CM-raw2.htm|awk '{print $1}')
  printf "Number of lines: ${NUM_BOXES}"

  if [ ${NUM_BOXES} -gt "0" ]; then
# Strip off just the prices of the top 3
    cat CM-raw2.htm |sed  's/\.//g;s/\,/\./g;s/.*\(>.*€\).*\(>.*€\).*/\1 \2/;s/>//g'|\
          head -3|sed 's/€/,/g;s/,$//'|tr  '\n' ','|sed 's/,$//' > CM-prices
    total=`cat CM-prices |awk -F "," '{print $1 + $2 + $3 + $4 + $5 + $6}'|sed 's/\..*//'`
    printf "TOTAL:\t${total}"
    average=$(( $total / ${NUM_BOXES} ))
    printf "${expansion},${average}\n">> $OUTFILE
  else
    printf "NO DATA FOR ${expansion}\n"
  fi

# Cleanup
  rm CM-raw.htm CM-raw2.htm

