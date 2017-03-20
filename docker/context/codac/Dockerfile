FROM gxcore:latest
# MAINTAINER Marcin Cieslik, marcin.cieslik@gmail.com
RUN Rscript -e 'source("http://bioconductor.org/biocLite.R");  biocLite(c("optparse", "igraph", "stringr", "data.table", "S4Vectors", "IRanges", "GenomeInfoDb", "GenomicRanges", "GenomicFeatures", "Biostrings", "ShortRead", "rtracklayer", "BSgenome", "BSgenome.Hsapiens.UCSC.hg38", "circlize"))'
ARG CODAC_VER
COPY samtools /bin/samtools
COPY inchworm /bin/inchworm
COPY codac_$CODAC_VER.tar.gz /tmp/codac_$CODAC_VER.tar.gz
RUN R CMD INSTALL /tmp/codac_$CODAC_VER.tar.gz && rm /tmp/codac_$CODAC_VER.tar.gz
ENV REF_PATH="/refs/cache/hts-ref/%2s/%2s/%s" REF_CACHE="/refs/cache/hts-ref/%2s/%2s/%s"
