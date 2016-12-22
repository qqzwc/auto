#!/bin/sh
echo ¨================start repo sync===============¨  
repo sync -f -j10
while [ $? == 1 ]; do
echo ¨================sync failed, re-sync again=============¨  
sleep 3
repo sync -f -q -j10  
done  
