#!/usr/bin/env bash
HERE="$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"
docker run --privileged \
       -v /tmp:/tmp \
       -v $HERE:/build \
       --hostname=$HOSTNAME -e USER=$USER --user=$USER -e HOME=/build -w /build \
       "gxuser:latest" /build/deps/build.sh
