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


F=update_block.xml

cp scripts/$F temp/$F

CONT=`ckyorn -Q -d yes -p "Turn on 0+ call blocking? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a native number."
        sed -e "/0\+/s/\"N/\"Y/" temp/$F > TMP_$F ;mv TMP_$F temp/$F
                ;;
        esac
CONT=`ckyorn -Q -d yes -p "Turn on International call blocking? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a native number."
        sed -e "/INTL/s/\"N/\"Y/" temp/$F > TMP_$F ;mv TMP_$F temp/$F
                ;;
        esac
CONT=`ckyorn -Q -d yes -p "Turn on 411 call blocking? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a native number."
        sed -e "/411/s/\"N/\"Y/" temp/$F > TMP_$F ;mv TMP_$F temp/$F
                ;;
        esac
CONT=`ckyorn -Q -d yes -p "Turn on DA blocking? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a native number."
        sed -e "/\"DA/s/\"N/\"Y/" temp/$F > TMP_$F ;mv TMP_$F temp/$F
                ;;
        esac
CONT=`ckyorn -Q -d yes -p "Turn on NDA blocking? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a native number."
        sed -e "/NDA/s/\"N/\"Y/" temp/$F > TMP_$F ;mv TMP_$F temp/$F
                ;;
        esac
CONT=`ckyorn -Q -d yes -p "Turn on ACB blocking? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a native number."
        sed -e "/ACB/s/\"N/\"Y/" temp/$F > TMP_$F ;mv TMP_$F temp/$F
                ;;
        esac
CONT=`ckyorn -Q -d yes -p "Turn on CASUAL blocking? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a native number."
        sed -e "/CASUAL/s/\"N/\"Y/" temp/$F > TMP_$F ;mv TMP_$F temp/$F
                ;;
        esac


sed -e "s/PHONEN/$1/g" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAupdate.properties TMP_$F

exit
