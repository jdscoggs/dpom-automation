#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1
FNAME=$2

F=act_VM01.xml
readme="Usage: ./$F <DPhone Num> <Sub First Name> <Wireless Phone>\\n\n
     Example: ./$F 55555555555 Snidely 7172345555"

# Help info

if [ $PHONEN = "-h" ]; then
        echo ""
        echo $readme
	echo ""
        exit
fi
cp scripts/$F temp/$F

sed -e "s/PHONEN/$PHONEN/g" -e "s/FNAME/$FNAME/" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAact.properties TMP_$F

exit
