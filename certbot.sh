#!/bin/sh

set -e

if [ "$HOST" == "" ]
then
    echo "need host from env"
    exit 1
fi

if [ "$(which certbot)" == "" ]
then
    echo "need certbot"
    exit 1
fi

if [ "$EMAIL" == "" ]
then
    EMAIL="$(md5sum /proc/sys/kernel/random/uuid | cut -d ' ' -f1)@gmail.com"
fi

TARGET=$1

if [[ "$TARGET" == "" ]]
then
    TARGET="./"
fi

mkdir -p $TARGET

certbot --nginx -n -d $HOST --agree-tos --email $EMAIL

ln -s /etc/letsencrypt/live/$EMAIL/fullchain.pem $TARGET/cert
ln -s /etc/letsencrypt/live/$EMAIL/privkey.pem $TARGET/key