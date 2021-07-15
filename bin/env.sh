#!/bin/sh
if [ "$HOST" == "" ]
then
    HOST="example.com"
fi

if [ "$UUID" == "" ]
then
    UUID="$(cat /proc/sys/kernel/random/uuid)"
fi

if [ -f ./info.txt ]
then
    rm ./info.txt
fi

echo "UUID : $UUID" >> ./info.txt
