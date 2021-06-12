#!/bin/sh
TAG=$1
if [ "$TAG" == "" ]
then
    TAG="latest"
fi

docker build -t xiaoshao97/xray-server:$TAG $PWD