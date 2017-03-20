#!/usr/bin/env bash

## GXCORE
export GXCORE_REL=1.5.0-r1
export USER=$USER
export USERID=`id -u`
docker build -t gxcore:$GXCORE_REL --build-arg user=$USER --build-arg userid=$USERID context/gxcore
docker tag gxcore:$GXCORE_REL gxcore:latest

mkdir -p image
docker save -o image/gxcore_$GXCORE_REL.tar gxcore:$GXCORE_REL
