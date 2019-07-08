#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1
PIC1=$2
LPIC=$3
IPIC=$3
F=update_pic.xml

readme="Usage: ./$F <DPhone Num> PIC LPIC IPIC\\n\n
     Example: ./$F 55555555555 0555 0333 0444"

# Help info

if [ $PHONEN = "-h" ]; then
        echo ""
        echo $readme
	echo ""
        exit
fi

cp scripts/$F temp/$F


sed -e "s/PHONEN/$1/g" -e "s/PIC1/$PIC1" -e "s/LPIC/$LPIC" -e "s/IPIC/$IPIC" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAupdate.properties TMP_$F

exit
