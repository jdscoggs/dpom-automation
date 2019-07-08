#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#

PHONEN=$1

readme="Usage: ./$F <DPhone Num>\\n\n
     Example: ./$F 55555555555"

# Help info

if [ $PHONEN = "-h" ]; then
        echo ""
        echo $readme
	echo ""
        exit
fi


F=update_lnp.xml

cp scripts/$F temp/$F

CONT=`ckyorn -Q -d yes -p "Update LNP to YES? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a native number."
        sed -e "/LNPTrigger/s/N/Y/" temp/$F > TMP_$F ;mv TMP_$F temp/$F
                ;;
        esac
        
sed -e "s/PHONEN/$1/g" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAupdate.properties TMP_$F

exit
