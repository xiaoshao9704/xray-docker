#!/bin/sh
set -e

if [ "$HOST" == "" ]
then
    echo "need host from env"
    exit 1
fi

if [ "$EMAIL" == "" ]
then
    EMAIL="$(md5sum /proc/sys/kernel/random/uuid | cut -d ' ' -f1)@gmail.com"
fi

TARGET="/xray/certificate"

mkdir -p $TARGET

certbot --nginx -n -d $HOST --agree-tos --keep --email $EMAIL

rm -f $TARGET/cert $TARGET/key
ln -s /etc/letsencrypt/live/$HOST/fullchain.pem $TARGET/cert
ln -s /etc/letsencrypt/live/$HOST/privkey.pem $TARGET/key