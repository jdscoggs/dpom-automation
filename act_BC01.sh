#!/bin/sh
# Quick and dirty shell script for PBI testing
# Dan Scoggins
#


PHONEN=$1
MAC=$2
TP=$3
FNAME=$4
pic1=0333
lpic=0444
ipic=0555
F=act_BC01.xml
readme="Usage: ./$F <DPhone Num> <MAC Addr> <Term Port> <Sub First Name>\\n\n
     Example: ./$F 55555555555 fffe00112233 2 Snidely"

# Help info

if [ $PHONEN = "-h" ]; then
        echo ""
        echo $readme
	echo ""
        exit
fi

cp scripts/$F temp/$F

CONT=`ckyorn -Q -d yes -p "Is this a Ported number? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a native number."
        sed -e "s/Ported/Native/" temp/$F > TMP_$F ;mv TMP_$F temp/$F
                ;;
        esac

CONT=`ckyorn -Q -d yes -p "Is this a Secondary number? (Default Yes)?"` || exit $?
        case $CONT in
        [yY]*)  ;;
        *)
        echo "Digital Phone will be provisioned as a Primary number."
        sed -e "s/Primary/Secondary/" temp/$F > TMP_$F;mv TMP_$F temp/$F
                ;;
        esac

sed -e "s/PHONEN/$1/g" -e "s/MAC/$2/g" -e "s/TP/$3/" -e "s/FNAME/$4/" -e "s/pic1/$pic1/" -e "s/lpic/$lpic/" -e "s/ipic/$ipic/" temp/$F > TMP_$F

. ./weblogic81/server/bin/setWLSEnv.sh

java SOAPClientNew dpomQAact.properties TMP_$F

exit
