#!/bin/sh
ALL_PKG=`grep -v "\!--\|notdefault" .repo/manifest.xml|grep project |awk '{print $3}' |cut -d'"' -f2`
ERR_PKG=""
T_PKG=$ALL_PKG

while [ 1 ]
do
    for i in $T_PKG
    do
        grep "$i" success.pkg >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            continue
        fi
        repo sync $i
        if [ $? -ne 0 ];then
            echo "SYNC Error $i"
            ERR_PKG="$ERR_PKG $i"
            continue
        else
            grep "$i" success.pkg >/dev/null 2>&1
            if [ $? -ne 0 ]; then
                echo "$i" >> success.pkg
            fi
            echo "SYNC Success $i"
        fi
    done

    if [ "$ERR_PKG" = "" ];then
        echo "SYNC ALL"
        exit 0
    else
        T_PKG=$ERR_PKG
        ERR_PKG=""
    fi
done
