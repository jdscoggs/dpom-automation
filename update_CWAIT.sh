#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1
FNAME=$2
F=update_CNAM.xml

readme="Usage: ./$F <DPhone Num> <Sub First Name>\\n\n
     Example: ./$F 55555555555 Snidely"

# Help info

if [ $PHONEN = "-h" ]; then
        echo ""
        echo $readme
	echo ""
        exit
fi

cp scripts/$F temp/$F

sed -e "s/PHONEN/$PHONEN/g" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAupdate.properties TMP_$F

exit
