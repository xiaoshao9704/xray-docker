#!/bin/sh

kill -9 `ps aux | grep xray | grep -v grep | awk '{ print $1 }'`