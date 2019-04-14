#!/bin/bash

#export DEBIAN_FRONTEND=noninteractive


##############################
# Testing without GNU Parallel
##############################
pwd
cd aircraft
./install_aircrafts.sh
#./update_aircraft.sh
#./extract.sh
./clean.sh

cd ..
pwd
cd scenes
./install_scenary.sh
#./update_scenery.sh
#./extract.sh
./clean.sh
cd ..
pwd
rm -rfv aircraft/*zip
rm -rfv scenes/*zip
#######################




#unset DEBIAN_FRONTEND=noninteractive
