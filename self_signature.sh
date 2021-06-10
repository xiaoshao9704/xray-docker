#!/bin/sh
TARGET=$1

if [[ "$TARGET" == "" ]]
then
    TARGET="./"
fi

mkdir -p $TARGET

echo "certificate build start in $TARGET"

UUID="$(cat /proc/sys/kernel/random/uuid)"

openssl req -newkey rsa:2048 -nodes -keyout $TARGET/key_$UUID.pem -x509 -days 3650 -subj "/C=HK/ST=Tuen Mun District/L=Tuen Mun District/O=Example/OU=Example Software/CN=example.com/emailAddress=example@example.com" -out $TARGET/cert_$UUID.pem

if [[ -f $TARGET/key ]]
then
    rm $TARGET/key
fi
if [[ -f $TARGET/cert ]]
then
    rm $TARGET/cert
fi

ln -s $TARGET/key_$UUID.pem $TARGET/key
ln -s $TARGET/cert_$UUID.pem $TARGET/cert

echo "certificate build done"