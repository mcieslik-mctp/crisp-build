#!/usr/bin/env bash
DOCKER_IMAGE="crisp:latest"
NCORES=16
MEMORY=6
SETTINGS="-lib_merge lane --debug"

##
HERE="$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))" && cd $HERE
ROOT="$(dirname $(dirname $HERE))"


##
JOB=$(basename $HERE)
USRID=$(id -u)
LOGDIR=$HERE/log
TMPDIR=$HERE/tmp
REPDIR=$ROOT/repo
REFDIR=$ROOT/refs
RUNDIR=$HERE

## LOGS
echo -e $(date) >> $LOGDIR/$JOB.init.timestamp
mkdir -p $RUNDIR/out
JSL=$RUNDIR/out/scr.log
echo -e "job:\t"$JOB >> $JSL
echo -e "start:\t"$(date) > $JSL
echo -e "hostname:\t"$HOSTNAME >> $JSL
echo -e "ncores:\t"$NCORES >> $JSL
echo -e "memory:\t"$MEMORY >> $JSL
echo -e "docker_image:\t"$DOCKER_IMAGE >> $JSL

echo -e "docker start:\t"$(date) >> $JSL
CONTID=$(docker run -d --privileged \
                -e NCORES="$NCORES" -e MEMORY="$MEMORY" -e SETTINGS="$SETTINGS" \
                -v $RUNDIR:/run \
                -v $TMPDIR:/tmp \
                -v $REFDIR:/refs \
                -v $REPDIR:/repo \
                --user $USRID \
                $DOCKER_IMAGE /run/run.sh 2>> $JSL)
echo -e "container_id:\t"$CONTID >> $JSL
docker attach $CONTID &>> $JSL
REMOVED=$(docker rm -f $CONTID)

##
echo -e "removed:\t"$REMOVED >> $JSL
echo -e "docker removed:\t"$REMOVED >> $JSL
echo -e "docker end:\t"$(date) >> $JSL
echo -e "end:\t"$(date) >> $JSL
echo -e $(date) >> $LOGDIR/$JOB.fini.timestamp
