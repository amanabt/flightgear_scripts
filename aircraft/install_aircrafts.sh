#!/bin/bash

source "../scripts/progress_bar.sh"
source "../scripts/text_formatting.sh"

./update_aircraft.sh
./extract.sh

printf "${BRed}Installing Aircrafts\n${Color_Off}"

STR="$(wc -l aircraft_list.txt)"
IFS=' ' read -ra TOTAL_AIRCRAFTS <<< "$STR"    #Convert string to array
i=0

sudo -v

for dir in */ ; do
	directory=${dir:0:-1}
	sudo rsync -rah $directory /usr/share/games/flightgear/Aircraft
    i=$((i + 1))
    ProgressBar ${i} ${TOTAL_AIRCRAFTS} ${directory}
done
