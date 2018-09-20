#!/bin/bash

for filename in *.zip ; do
	echo $filename
	unzip -q $filename
done


