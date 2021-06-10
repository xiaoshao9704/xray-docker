#!/bin/sh
TARGET="/xray/certificate"

mkdir -p $TARGET

echo "certificate build start in $TARGET"

UUID="$(cat /proc/sys/kernel/random/uuid)"

ORGANIZATION="$(md5sum $UUID)"

openssl req -newkey rsa:2048 -nodes -keyout $TARGET/key_$UUID.pem -x509 -days 3650 -subj "/C=HK/ST=Tuen Mun District/L=Tuen Mun District/O=Example/OU=Example Software/CN=$UUID.com/emailAddress=example@example.com" -out $TARGET/cert_$UUID.pem

rm -f $TARGET/cert $TARGET/key
ln -s $TARGET/key_$UUID.pem $TARGET/key
ln -s $TARGET/cert_$UUID.pem $TARGET/cert

echo "certificate build done"