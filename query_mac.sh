#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

MAC=$1
F=query_MAC.xml

readme="Usage: ./$F <MAC Addr>\\n\n
     Example: ./$F fffe11223344"

# Help info

if [ $PHONEN = "-h" ]; then
        echo ""
        echo $readme
	echo ""
        exit
fi

cp scripts/$F temp/$F

sed -e "s/MAC/$1/g" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAquery.properties TMP_$F

exit
