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
      printf "${SET_NAME},${SET_PRICE}\n"
      fi
done < /tmp/prices3
