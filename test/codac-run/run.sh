#!/usr/bin/env bash
cd /run

echo -e "start:\t"$(date) > /run/out/run.log

cat lib_sheet.tsv | while read LINE
do
    RUN=$(echo $LINE | cut -d " " -f 1)
    CFG=$(echo $LINE | cut -d " " -f 2)
    SID=$(basename $RUN)
    mkdir -p out/$SID/
    Rscript -e 'library(methods);codac::detect()' $CFG $RUN out/$SID/
    Rscript -e 'library(methods);codac::report()' $CFG out/$SID/$SID-codac-spl.rds out/$SID/$SID-codac-sv.rds out/$SID
    Rscript -e 'library(methods);codac::report()' $CFG out/$SID/$SID-codac-spl.rds out/$SID/$SID-codac-ts.rds out/$SID
    Rscript -e 'library(methods);codac::report()' $CFG out/$SID/$SID-codac-spl.rds out/$SID/$SID-codac-bs.rds out/$SID
    Rscript -e 'library(methods);codac::report()' $CFG out/$SID/$SID-codac-spl.rds out/$SID/$SID-codac-sl.rds out/$SID
    Rscript -e 'library(methods);codac::qc.report()' $CFG out/$SID/$SID-codac-stat.rds out/$SID
    Rscript -e 'library(methods);codac::assemble()' $CFG out/$SID/$SID-codac-sv.rds out/$SID
    
done

echo -e "end:\t"$(date) > /run/out/run.log
