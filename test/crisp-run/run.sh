#!/usr/bin/env bash
cd /run

echo -e "start:\t"$(date) > /run/out/run.log
source /code/src.sh

mkdir -p out
/code/pipeline.py \
    -inp /repo \
    -out /run/out/ \
    -ls  /run/out/pipe.log \
    -ncores $NCORES -memory $MEMORY \
    -star_mem LoadAndKeep \
    -novo_mem 32G \
    $SETTINGS \
    /run/lib_sheet.tsv 2>> /run/out/run.log

echo -e "end:\t"$(date) >> /run/out/run.log
