#!/usr/bin/env bash
HERE="$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"
GXCORE_VER=1.5.0
GXCORE_REL=$GXCORE_VER-r1

wget -P $HERE/image https://storage.googleapis.com/crisp-mctp/gxcore/$GXCORE_VER/gxcore_$GXCORE_REL.tar 
docker load -i image/gxcore_1.5.0-r1.tar
docker tag gxcore:$GXCORE_REL gxcore:latest
