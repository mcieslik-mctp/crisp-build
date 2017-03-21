Requirements:
```
$ docker -v
Docker version 17.03.0-ce, build 60ccb22
$ wget
```

Step 1: Prepare build environment
```
git clone https://github.com/mctp/crisp-build
cp <<NOVOALIGN LICENSE KEY>> crisp-build/novoalign.lic
cd crisp-build
```

Step 2: Build GXUSER Docker image
```
# pre-build base image recommended (fast)
bash docker/pull_image_gxcore.sh
# build from scratch (~2-3h)
bash docker/build_image_gxcore.sh
bash docker/build_image_gxuser.sh
```

Step 3: Prepare dependencies
```
bash deps-build.sh
```

Step 4: Build CRISP and CODAC Docker images
```
bash docker/build_image_crisp.sh
bash docker/build_image_codac.sh
```

Step 5: Test CRISP image:
```
wget -P repo https://storage.googleapis.com/crisp-mctp/test.data/fastq/mctp_SI_12764_C8LJ1ANXX_6_1.fq.gz
wget -P repo https://storage.googleapis.com/crisp-mctp/test.data/fastq/mctp_SI_12764_C8LJ1ANXX_6_2.fq.gz
bash test/crisp-run/init.sh
```

Step 6: Test CODAC image:
```
wget -P repo https://storage.googleapis.com/crisp-mctp/test.data/crisp/2.0.0/VCaP-poly-SI_12764-C8LJ1ANXX.tar.gz
tar xf repo/VCaP-poly-SI_12764-C8LJ1ANXX.tar.gz -C repo
bash test/codac-run/init.sh
```
