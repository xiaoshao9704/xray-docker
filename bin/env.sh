#!/bin/sh
if [ "$HOST" == "" ]
then
    HOST="example.com"
fi

if [ "$UUID" == "" ]
then
    UUID="$(cat /proc/sys/kernel/random/uuid)"
fi

if [ "$PASSWORD" == "" ]
then
    PASSWORD=$UUID
fi

if [ "$EMAIL" == "" ]
then
    EMAIL="$UUID@uuid.xray"
fi

if [ "$WEBSOCKET" == "" ]
then
    WEBSOCKET="/$(cat /proc/sys/kernel/random/uuid)"
fi

if [ "$VMESSTCP" == "" ]
then
    VMESSTCP="/$(cat /proc/sys/kernel/random/uuid)"
fi

if [ "$VMESSWS" == "" ]
then
    VMESSWS="/$(cat /proc/sys/kernel/random/uuid)"
fi

if [ -f ./info.txt ]
then
    rm ./info.txt
fi

echo "UUID : $UUID" >> ./info.txt
echo "PASSWORD : $PASSWORD" >> ./info.txt
echo "EMAIL : $EMAIL" >> ./info.txt
echo "WEBSOCKET : $WEBSOCKET" >> ./info.txt
echo "VMESSTCP : $VMESSTCP" >> ./info.txt
echo "VMESSWS : $VMESSWS" >> ./info.txt
