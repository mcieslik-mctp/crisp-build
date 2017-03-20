FROM ubuntu:14.04 

# Changes:
#   - 1.5.0 system bump (LTS)
#   - 1.4.2.9 add sqlite3 beamer
#   - 1.4.2.8 system bump
#   - 1.4.2.7 system bump
#   - 1.4.2.6 system bump
#   - 1.4.2.5 add libxpm-dev
#   - 1.4.2.4 user from ARG
#   - 1.4.2.3 mesa common
#   - 1.4.2.2 perl deps + emacs replacement
#   - 1.4.2.1 perl deps
#   - 1.4.2.0 update
#   - 1.4.1.8 kkasaian
#   - 1.4.1.7 pkozbial
#   - 1.4.1.6 add parallel
#   - 1.4.1.5 add gcloud SDK
#   - 1.4.1.4 remove gcsfuse
#   - 1.4.1.3 add gcsfuse
#   - 1.4.1.2 revert to emacs 24.5
#   - 1.3.1.1 revert to emacs 24.4
#   - 1.3.1.0 add users, remove julia & emacs 24.5 
#   - 1.3.0.5 system update
#   - 1.3.0.4 add GSL
#   - 1.3.0 rebuild & restructure
#   - 1.2.6 fixed curl libs
#   - 1.2.5 added moke and papy 
#   - 1.2.4 added iotop system update
#   - 1.2.3 system update
#   - 1.2.2 system update & emacs 24.4
#   - 1.2.1 system update
#   - 1.2.0 system update and rename
#   - 1.1.1 added julia updated system
#   - 1.1.0 update added latex
#   - 1.0.2 added libhdf5-dev; fixed initial updated
#   - 1.0.1 added rcurl build dependencies

# MAINTAINER Marcin Cieslik, marcin.cieslik@gmail.com
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y --fix-missing

# SETUP
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository -y ppa:webupd8team/java
RUN add-apt-repository -y ppa:pi-rho/dev
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN echo 'deb http://cran.rstudio.com/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list
RUN apt-get update

# LOCALE
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8 && dpkg-reconfigure locales

# LIBRARIES
RUN apt-get install -y libboost-all-dev libtbb-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev libxpm-dev libhdf5-dev
RUN apt-get install -y sqlite3 libsqlite3-dev

# TOOLS
RUN apt-get install -y build-essential checkinstall
RUN apt-get install -y cmake cvs subversion git-core mercurial
RUN apt-get install -y fish tmux wget

# R
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get build-dep -y r-base
RUN apt-get install -y --force-yes r-base

# Python
RUN apt-get build-dep -y python python-numpy python-scipy
RUN apt-get install -y python python-numpy python-scipy
RUN apt-get install -y virtualenvwrapper

# JAVA (7u55)
RUN apt-get install -y oracle-java7-installer
RUN apt-get install -y oracle-java7-set-default

# remaining latex
RUN apt-get install -y texlive-font-utils latex-beamer

# pigz
RUN apt-get install -y pigz
RUN apt-get install -y htop
RUN apt-get install -y tree

    # valgrind
RUN apt-get install -y valgrind

# performance
RUN apt-get install -y iotop

# performance
RUN apt-get install -y curl

# moke and papy systemwide
RUN pip install moke
RUN pip install papy

# GSL
RUN apt-get install -y gsl-bin

# PARALLEL
RUN apt-get install -y parallel

# PERL (VEP)
RUN apt-get install -y libdbd-mysql-perl libarchive-zip-perl libdbi-perl

RUN apt-add-repository -y ppa:ubuntu-elisp/ppa && \
        apt-get update -y && \
        apt-get install -y emacs-snapshot

# FINALIZE
RUN apt-get update -y --fix-missing && apt-get dist-upgrade -y 

## CUSTOM
RUN cd /usr/local/bin && \
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.tar.gz && \
    tar xf google-cloud-sdk.tar.gz && \
    export CLOUDSDK_CORE_DISABLE_PROMPTS=1 && \
    ./google-cloud-sdk/install.sh


# SUDO
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers
