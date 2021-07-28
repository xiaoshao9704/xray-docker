#!/bin/sh
TAG=$1
if [ "$TAG" == "" ]
then
    TAG="latest"
fi

docker buildx build --platform linux/amd64,linux/arm64 -t xiaoshao97/xray-server:$TAG $(cd $(dirname $0) && pwd -P) --push