#!/usr/bin/env bash
export ROOT="$(dirname $(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )))"

## CRISP
export CRISP_VER=2.0.0
export CRISP_REL=$CRISP_VER-r1
export CRISP_PATH=$ROOT/crisp
export CRISP_FILE=$CRISP_PATH/release/crisp_novo_$CRISP_REL.tar.gz
cp $CRISP_FILE crisp
docker build --build-arg CRISP_REL=$CRISP_REL -t crisp:$CRISP_REL crisp
rm crisp/$(basename $CRISP_FILE)
docker tag crisp:$CRISP_REL crisp:latest


## CODAC
export CODAC_VER=3.2.2
export CODAC_REL=$CODAC_VER-r1
export CODAC_PATH=$ROOT/codac
export CODAC_FILE=$CODAC_PATH/release/codac_$CODAC_VER.tar.gz
export SAMTOOLS_BIN=$CODAC_PATH/bin/samtools
export INCHWORM_BIN=$CODAC_PATH/bin/inchworm
cp $CODAC_FILE codac
cp $SAMTOOLS_BIN codac
cp $INCHWORM_BIN codac
docker build --build-arg CODAC_VER=$CODAC_VER -t codac:$CODAC_REL codac
rm codac/$(basename $CODAC_FILE) codac/samtools codac/inchworm
docker tag codac:$CODAC_REL codac:latest

(
    echo "images/crisp_$CRISP_REL.tar crisp:$CRISP_REL";
    echo "images/codac_$CODAC_REL.tar codac:$CODAC_REL"
) | xargs -d '\n' -n1 -P8 sh -c 'docker save -o $0'
