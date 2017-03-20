#!/usr/bin/env bash
HERE=$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))
ROOT=$(dirname $HERE)

## CODAC
CODAC_VER=3.2.2
CODAC_REL=$CODAC_VER-r1
CODAC_FILE=$ROOT/deps/codac/codac_$CODAC_VER.tar.gz
SAMTOOLS_BIN=$ROOT/deps/bin/samtools
INCHWORM_BIN=$ROOT/deps/bin/inchworm
cp $CODAC_FILE $HERE/context/codac
cp $SAMTOOLS_BIN $HERE/context/codac
cp $INCHWORM_BIN $HERE/context/codac
docker build --build-arg CODAC_VER=$CODAC_VER -t codac:$CODAC_REL $HERE/context/codac
rm $HERE/context/codac/$(basename $CODAC_FILE) $HERE/context/codac/samtools $HERE/context/codac/inchworm
docker tag codac:$CODAC_REL codac:latest
docker save -o $HERE/image/codac_$CODAC_REL.tar codac:$CODAC_REL
