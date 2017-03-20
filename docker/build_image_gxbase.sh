#!/usr/bin/env bash
HERE="$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"
GXBASE_REL=1.5.0-r1
USER=$USER
USERID=`id -u`
docker build -t gxbase:$GXBASE_REL --build-arg user=$USER --build-arg userid=$USERID $HERE/context/gxbase
docker tag gxbase:$GXBASE_REL gxbase:latest
mkdir -p $HERE/image
docker save -o $HERE/image/gxbase_$GXBASE_REL.tar gxbase:$GXBASE_REL
