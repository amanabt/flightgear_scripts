#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

pwd
#######################
# Install GNU Parallel
#######################

wget https://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2
tar jxf parallel-latest.tar.bz2 --one-top-level=parallel-latest --strip- components=1
cd parallel-latest
./configure && make
sudo make install
parallel --version #check if parallel has been installed
yes 'will cite' | parallel --citation
cd ../

unset DEBIAN_FRONTEND=noninteractive
