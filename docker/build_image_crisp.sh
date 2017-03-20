#!/usr/bin/env bash
HERE=$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))
ROOT=$(dirname $HERE)

## CRISP
CRISP_VER=2.0.0
CRISP_REL=$CRISP_VER-r1
CRISP_PATH=$ROOT/deps/crisp
CRISP_FILE=$CRISP_PATH/crisp_novo_$CRISP_VER.tar.gz
cp $CRISP_FILE $HERE/context/crisp
docker build --build-arg CRISP_REL=$CRISP_REL -t crisp:$CRISP_REL $HERE/context/crisp
rm $HERE/context/crisp/$(basename $CRISP_FILE)
docker tag crisp:$CRISP_REL crisp:latest
docker save -o $HERE/image/crisp_$CRISP_REL.tar crisp:$CRISP_REL
