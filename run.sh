#!/bin/sh
cat /xray/info.txt
nginx
/xray/xray-core/xray -config /xray/server.json