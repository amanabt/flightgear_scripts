#!/bin/bash

#export DEBIAN_FRONTEND=noninteractive


##############################
# Testing without GNU Parallel
##############################
pwd
cd aircraft
./update_aircraft.sh
./extract.sh
./clean.sh

cd ..
pwd
cd scenes
./update_scenery.sh
./extract.sh
./clean.sh
cd ..
pwd
rm -rfv aircraft/*zip
rm -rfv scenes/*zip
#######################




#unset DEBIAN_FRONTEND=noninteractive
