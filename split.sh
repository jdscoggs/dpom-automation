#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1
CPHONEN=$2

F=join.xml

readme="Usage: ./$F <DPhone Num> <Child Phone>\\n\n
     Example: ./$F 55555555555 7172345555"

# Help info

if [ $PHONEN = "-h" ]; then
        echo ""
        echo $readme
	echo ""
        exit
fi


cp scripts/$F temp/$F

CONT=`ckyorn -Q -d yes -p "Is this a Secondary number? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a Primary number."
        sed -e "s/Secondary/Primary/" temp/$F > TMP_$F;mv TMP_$F temp/$F
                ;;
        esac

CONT=`ckyorn -Q -d yes -p "Is this a Landline number? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a Landline number."
        sed -e "s/Wireless/Landline/" temp/$F > TMP_$F;mv TMP_$F temp/$F
                ;;
        esac



sed -e "s/PHONEN/$1/g" -e "s/CPHONE/$2/" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAupdate.properties TMP_$F

exit
