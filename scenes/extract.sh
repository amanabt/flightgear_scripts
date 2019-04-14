#!/bin/bash

source "../scripts/progress_bar.sh"

STR="$(whereis parallel)"
IFS=':' read -ra IS_PARALLEL <<< "$STR"    #Convert string to array

STR="$(wc -l scenery_list.txt)"
IFS=' ' read -ra TOTAL_SCENERY <<< "$STR"    #Convert string to array
i=0

if [ -z "${IS_PARALLEL[1]}" ]; then
    echo "GNU Parallel not found!"
    for filename in *.zip ; do
        i=$((i + 1))
        ProgressBar ${i} ${TOTAL_SCENERY} ${filename}
    	directory=${filename%.*}
        #echo "Directory: " $directory
        unzip -n -qq $filename -d $directory
    done

else
    cat scenery_list.txt | parallel --bar -n 1 -I {} -j 8 "unzip -n -qq {} -d {.}"
fi

