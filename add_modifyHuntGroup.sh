#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1
PHONEN1=$2
PHONEN2=$3
PHONEN3=$4
PHONEN4=$5

F=add_modifyHuntGroup.xml

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

sed -e "s/PHONEN/$1/g" -e "s/PHONEN1/$2/" -e "s/PHONEN2/$PHONEN2/" -e "s/PHONEN3/$PHONEN3/" -e "s/PHONEN4/$PHONEN4/" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAupdate.properties TMP_$F

exit
