#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1
NPHONEN=$2
F=transfer_acct.xml

readme="Usage: ./$F <Account #> <New Account #>\\n\n
     Example: ./$F 55555555555 7172345555"

# Help info

if [ $PHONEN = "-h" ]; then
        echo ""
        echo $readme
	echo ""
        exit
fi

cp scripts/$F temp/$F

sed -e "s/PHONEN/$1/g" -e "s/NPHONEN/$2/" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAupdate.properties TMP_$F

exit
