#!/bin/bash

for filename in *.zip ; do
	directory=${filename:0:-4}
	echo $directory
	if ! [ -d "$directory" ]; then
		echo "Extracting: " $directory
		mkdir -p $directory
		unzip -n -q $filename -d $directory
	fi
done


