#!/bin/bash

##############################
# Testing without GNU Parallel
##############################
cd aircrafts
./install_aircrafts.sh
cd ..
cd scenes
./install_scenary.sh
cd ..
#######################



###########################
# Testing with GNU Parallel
###########################

#######################
# Install GNU Parallel
#######################

wget http://mirror.rasanegar.com/gnu/parallel/parallel-latest.tar.bz2
tar jxf parallel-latest.tar.bz2 --one-top-level=parallel-latest --strip-components=1
cd parallel-latest
./configure && make
sudo make install
parallel --version #check if parallel has been installed
cd ../

#######################
cd aircrafts
./install_aircrafts.sh
cd ..
cd scenes
./install_scenary.sh
cd ..
#######################
