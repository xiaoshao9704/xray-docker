#!/bin/sh

if [ ! -f /xray/info.txt ]
then
    sh /xray/bin/init.sh config
fi

if [ ! -x /xray/certificate ]
then
    sh /xray/bin/init.sh cert
fi

cat /xray/info.txt

/xray/xray-core/xray -config /xray/xray-core/server.json