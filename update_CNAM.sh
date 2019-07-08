#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1

readme="Usage: ./$F <DPhone Num> <Sub First Name> <Wireless Phone>\\n\n
     Example: ./$F 55555555555 Snidely 7172345555"

# Help info

if [ $PHONEN = "-h" ]; then
        echo ""
        echo $readme
	echo ""
        exit
fi


F=update_priv.xml

cp scripts/$F temp/$F

sed -e "s/PHONEN/$1/g" -e "s/PRIVACY/$2/" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAupdate.properties TMP_$F

exit
