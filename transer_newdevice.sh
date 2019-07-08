#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1
MAC=$2
MAC2=$3
F=transfer_newdevice.xml

readme="Usage: ./$F <DPhone Num> <Original MAC> <New MAC>\\n\n
     Example: ./$F 55555555555 fffe00000082 fffe00000083"

# Help info

if [ $PHONEN = "-h" ]; then
        echo ""
        echo $readme
	echo ""
        exit
fi



cp scripts/$F temp/$F

sed -e "s/PHONEN/$PHONEN/g" -e "s/MAC/$MAC/" -e "s/MAC2/$MAC2/" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAupdate.properties TMP_$F

exit
