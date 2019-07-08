#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1
PHONEN1=$2
F=update_changeTN.xml

readme="Usage: ./$F <DPhone Num> <New DPhone Num>\\n\n
     Example: ./$F 55555555555 7172345555"

# Help info

if [ $PHONEN = "-h" ]; then
        echo ""
        echo $readme
	echo ""
        exit
fi

cp scripts/$F temp/$F

sed -e "s/PHONEN/$PHONEN/g" -e "s/PHONEN1/$PHONEN1/" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAupdate.properties TMP_$F

exit
