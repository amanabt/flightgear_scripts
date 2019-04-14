#!/bin/bash

source "../scripts/progress_bar.sh"
source "../scripts/text_formatting.sh"

./update_scenery.sh
./extract.sh


printf "${BRed}Installing packages\n${Color_Off}"

STR="$(wc -l scenery_list.txt)"
#echo $STR
IFS=' ' read -ra TOTAL_SCENERY <<< "$STR"    #Convert string to array
i=0

sudo -v

for dir in */ ; do
	directory=${dir:0:-1}
	#echo $directory

	if [ -d "$directory/Objects" ]; then
		cd $directory/Objects
		#pwd
		sudo rsync -rah . /usr/share/games/flightgear/Scenery/Objects/
		cd ../../
	fi

	if [ -d "$directory/Terrain" ]; then
		cd $directory/Terrain
		#pwd
		sudo rsync -rah . /usr/share/games/flightgear/Scenery/Terrain
		cd ../../
	fi

    i=$((i + 1))
    ProgressBar ${i} ${TOTAL_SCENERY} ${directory}

done
