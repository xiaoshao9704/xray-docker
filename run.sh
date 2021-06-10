#!/bin/sh
set_env() {
    source ./env.sh
}

set_config() {
    cp ./server.json.template ./server.json
    sed -i "s/{{UUID}}/$UUID/g" ./server.json
    sed -i "s/{{PASSWORD}}/$PASSWORD/g" ./server.json
    sed -i "s/{{EMAIL}}/$EMAIL/g" ./server.json
    sed -i "s/{{WEBSOCKET}}/\\$WEBSOCKET/g" ./server.json
    sed -i "s/{{VMESSTCP}}/\\$VMESSTCP/g" ./server.json
    sed -i "s/{{VMESSWS}}/\\$VMESSWS/g" ./server.json
}

self_signature() {
    sh ./self_signature.sh /xray/certificate
}

if [ ! -f /xray/info.txt ]
then
    set_env
    set_config
fi

if [ ! -x /xray/certificate ]
then
    self_signature
fi

cat /xray/info.txt
nginx
/xray/xray-core/xray -config /xray/server.json &
top