#!/usr/bin/env bash
HERE="$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"
GXUSER_REL=1.5.0-r1
USER=$USER
USERID=`id -u`
docker build -t gxuser:$GXUSER_REL --build-arg user=$USER --build-arg userid=$USERID $HERE/context/gxuser
docker tag gxuser:$GXUSER_REL gxuser:latest
mkdir -p $HERE/image
docker save -o $HERE/image/gxuser_$GXUSER_REL.tar gxuser:$GXUSER_REL
