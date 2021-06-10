#!/bin/sh
TARGET=$1

if [[ "$TARGET" == "" ]]
then
    TARGET="./"
fi

mkdir -p $TARGET

echo "certificate build start in $TARGET"

openssl req -newkey rsa:2048 -nodes -keyout $TARGET/self_key.pem -x509 -days 3650 -subj "/C=HK/ST=Tuen Mun District/L=Tuen Mun District/O=Example/OU=Example Software/CN=$HOST/emailAddress=example@example.com" -out $TARGET/self_cert.pem

ln -s $TARGET/self_cert.pem $TARGET/cert
ln -s $TARGET/self_key.pem $TARGET/key

echo "certificate build done"