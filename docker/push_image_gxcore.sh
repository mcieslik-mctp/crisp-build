#!/usr/bin/env bash
HERE="$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"
GXCORE_VER=1.5.0
GXCORE_REL=$GXCORE_VER-r1

gsutil cp $HERE/image/gxcore_$GXCORE_REL.tar gs://crisp-mctp/gxcore/$GXCORE_VER/
