#!/bin/bash

./update_scenery.sh
./extract.sh

for dir in */ ; do
	directory=${dir:0:-1}
	echo $directory

	if [ -d "$directory/Objects" ]; then
		cd $directory/Objects
		pwd
		sudo rsync -rah . /usr/share/games/flightgear/Scenery/Objects/
		cd ../../
	fi

	if [ -d "$directory/Terrain" ]; then
		cd $directory/Terrain
		pwd
		sudo rsync -rah . /usr/share/games/flightgear/Scenery/Terrain
		cd ../../
	fi
done
