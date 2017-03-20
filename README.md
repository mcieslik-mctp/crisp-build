
Step 1: Prepare build environment
```
git clone https://github.com/mctp/crisp-build
cp <<NOVOALIGN LICENSE KEY>> crisp-build/novoalign.lic
cd crisp-build
```

Step 2: Build GXCORE Docker image
```
bash docker/build_image_gxcore.sh
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

Step 5: Test images
```
wget -P repo https://storage.googleapis.com/crisp-mctp/test.data/fastq/mctp_SI_12764_C8LJ1ANXX_6_1.fq.gz
wget -P repo https://storage.googleapis.com/crisp-mctp/test.data/fastq/mctp_SI_12764_C8LJ1ANXX_6_2.fq.gz

```
