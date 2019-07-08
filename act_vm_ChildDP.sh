#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1
FNAME=$2
DPHONEN=$3
LNAME=YEE
F=act_vm_ChildDP.xml
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

sed -e "s/PHONEN/$1/g" -e "s/FNAME/$2/" -e "s/DPHONEN/$3/g" -e "s/LNAME/$LNAME/" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAact.properties TMP_$F

exit
