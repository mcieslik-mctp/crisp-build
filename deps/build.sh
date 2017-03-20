#!/usr/bin/env bash
export DEPS="$(readlink -f $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"
export NOVO_KEY=/build/novoalign.lic
export REFS_VER=2.0.0
export CRISP_VER=2.0.0
export CODAC_VER=3.2.2
cd $DEPS


#### CLEAN
## setup
rm -rf $DEPS/{bin,refs,crisp,codac}
mkdir -p $DEPS/{bin,refs,crisp,codac}


#### DOWNLOAD
## get refs
wget https://storage.googleapis.com/crisp-mctp/refs/$REFS_VER/refs_$REFS_VER.tar.gz
tar xf refs_$REFS_VER.tar.gz
rm refs_$REFS_VER.tar.gz
## get crisp
wget https://storage.googleapis.com/crisp-mctp/crisp/$CRISP_VER/crisp_$CRISP_VER.tar.gz
tar xf crisp_$CRISP_VER.tar.gz -C crisp
rm crisp_$CRISP_VER.tar.gz
## get codac
cd $DEPS/codac
wget https://storage.googleapis.com/crisp-mctp/codac/$CODAC_VER/codac_$CODAC_VER.tar.gz
wget https://storage.googleapis.com/crisp-mctp/codac/$CODAC_VER/codac-motr1-$CODAC_VER-clbs.rds
wget https://storage.googleapis.com/crisp-mctp/codac/$CODAC_VER/codac-motr1-$CODAC_VER-csbs.rds
wget https://storage.googleapis.com/crisp-mctp/codac/$CODAC_VER/codac-motr1-$CODAC_VER-plbs.rds
wget https://storage.googleapis.com/crisp-mctp/codac/$CODAC_VER/codac-motr1-$CODAC_VER-psbs.rds
wget https://storage.googleapis.com/crisp-mctp/codac/$CODAC_VER/codac-motr1-$CODAC_VER-clbu.rds
wget https://storage.googleapis.com/crisp-mctp/codac/$CODAC_VER/codac-motr1-$CODAC_VER-csbu.rds
wget https://storage.googleapis.com/crisp-mctp/codac/$CODAC_VER/codac-motr1-$CODAC_VER-plbu.rds
wget https://storage.googleapis.com/crisp-mctp/codac/$CODAC_VER/codac-motr1-$CODAC_VER-psbu.rds
cd $DEPS


#### BIN
## build STAR
cp $DEPS/refs/tools/STAR_2.4.0g1.tgz .
tar xf STAR_2.4.0g1.tgz
cd STAR-STAR_2.4.0g1/source
make STAR
mv STAR $DEPS/bin
cd $DEPS
rm -rf STAR*
## Build Samtools
cp $DEPS/refs/tools/samtools-1.3.1.tar.bz2 .
tar xf samtools-1.3.1.tar.bz2
cd samtools-1.3.1
./configure
make
cd $DEPS
mv samtools-1.3.1/samtools $DEPS/bin
rm -rf samtools-1.3.1*
## Build Inchworm:
cp $DEPS/refs/tools/inchworm_19032017.tar.gz .
tar xf inchworm_19032017.tar.gz
cd Inchworm
./configure
make
cd $DEPS
mv Inchworm/src/inchworm $DEPS/bin
rm -rf Inchworm
rm inchworm_19032017.tar.gz


#### REFS
## build genomes
STAR=$DEPS/bin/STAR
mkdir -p $DEPS/refs/indices/star/Hsapiens_rRNA
cd $DEPS/refs/indices/star/Hsapiens_rRNA
$STAR --runMode genomeGenerate --genomeDir $DEPS/refs/indices/star/Hsapiens_rRNA \
      --genomeFastaFiles $DEPS/refs/genomes/Hsapiens_rRNA.fa --runThreadN 1 --genomeSAindexNbases 4
mkdir -p $DEPS/refs/indices/star/GRCh38.analysis_set.motr-v1-125-2
cd $DEPS/refs/indices/star/GRCh38.analysis_set.motr-v1-125-2
$STAR --runMode genomeGenerate --genomeDir $DEPS/refs/indices/star/GRCh38.analysis_set.motr-v1-125-2 \
      --genomeFastaFiles $DEPS/refs/genomes/GRCh38.analysis_set.fa --runThreadN $(cat /proc/cpuinfo  | grep 'processor      ' | wc -l) \
      --sjdbOverhang 125 --sjdbScore 2 --sjdbGTFfile $DEPS/refs/gtf/motr.v1/motr.v1-alig.gtf
cd $DEPS

#### CRISP
## package CRISP
cp $NOVO_KEY $DEPS/crisp/code/bin
tar --exclude="crisp_$CRISP_VER.tar.gz" \
    -zcf $DEPS/crisp/crisp_novo_$CRISP_VER.tar.gz --directory $DEPS/crisp code

#### CODAC
## nothing to do
