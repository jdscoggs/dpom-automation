#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1

readme="Usage: ./$F <DPhone Num>\\n\n
     Example: ./$F 55555555555"

# Help info

if [ $PHONEN = "-h" ]; then
        echo ""
        echo $readme
	echo ""
        exit
fi


F=query_CustID.xml

cp scripts/$F temp/$F

sed -e "s/PHONEN/$1/g" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAquery.properties TMP_$F

exit
