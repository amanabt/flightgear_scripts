#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

##############################
# Testing without GNU Parallel
##############################
pwd
cd aircraft
./install_aircrafts.sh
./clean.sh

cd ..
pwd
cd scenes
./install_scenary.sh
./clean.sh
cd ..
pwd
rm -rfv aircraft/*zip
rm -rfv scenes/*zip
#######################



###########################
# Testing with GNU Parallel
###########################

#######################
# Install GNU Parallel
#######################

wget https://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2
tar jxf parallel-latest.tar.bz2 --one-top-level=parallel-latest --strip-components=1
cd parallel-latest
./configure && make
sudo make install
parallel --version #check if parallel has been installed
cd ../

##############################
# Testing without GNU Parallel
##############################
pwd
cd aircraft
./install_aircrafts.sh
cd ..
pwd
cd scenes
./install_scenary.sh
cd ..
pwd
#######################

unset DEBIAN_FRONTEND=noninteractive
