#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1
F=update_vm_names.xml

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

CONT=`ckyorn -Q -d yes -p "Is this phone num Primary? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a native number."
        sed -e "/tn\ role/s/Secondary/Primary/" temp/$F > TMP_$F ;mv TMP_$F temp/$F
                ;;
        esac
        
sed -e "s/PHONEN/$1/g" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAupdate.properties TMP_$F

exit
