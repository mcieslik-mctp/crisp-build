#!/usr/bin/env bash
HERE="$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"
GXCORE_REL=1.5.0-r1
USER=$USER
USERID=`id -u`
docker build -t gxcore:$GXCORE_REL --build-arg user=$USER --build-arg userid=$USERID $HERE/context/gxcore
docker tag gxcore:$GXCORE_REL gxcore:latest
mkdir -p $HERE/image
docker save -o $HERE/image/gxcore_$GXCORE_REL.tar gxcore:$GXCORE_REL
