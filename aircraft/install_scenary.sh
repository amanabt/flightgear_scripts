#!/bin/bash

./update_aircraft.sh
./extract.sh

for dir in */ ; do
	directory=${dir:0:-1}
	echo $directory
	sudo rsync -rah $directory /usr/share/games/flightgear/Aircraft
done
