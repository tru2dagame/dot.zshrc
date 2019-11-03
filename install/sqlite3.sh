#!/bin/bash

# install from source code
now=$(date "+%F")
folder=/usr/local/src/sqlite3-$now

mkdir -p $folder && cd $folder
wget -O $folder/sqlite-$now.tar.gz \
     https://www.sqlite.org/src/tarball/sqlite.tar.gz?r=release && \
     tar xvfz sqlite-$now.tar.gz && \
     ./sqlite/configure --prefix=/usr && \
     make && \
     make install && \
     sqlite3 --version && \
     which sqlite3
