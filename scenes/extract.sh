#!/bin/bash

source "../scripts/progress_bar.sh"
source "../scripts/text_formatting.sh"

printf "${BRed}Extracting packages from zip files\n${Color_Off}"

STR="$(whereis parallel)"
IFS=':' read -ra IS_PARALLEL <<< "$STR"    #Convert string to array

STR="$(wc -l scenery_list.txt)"
IFS=' ' read -ra TOTAL_SCENERY <<< "$STR"    #Convert string to array
i=0

if [ -z "${IS_PARALLEL[1]}" ]; then
    echo "GNU Parallel not found!"
    for filename in *.zip ; do
    	directory=${filename%.*}
        #echo "Directory: " $directory
        unzip -u -n -qq $filename -d $directory
        i=$((i + 1))
        ProgressBar ${i} ${TOTAL_SCENERY} ${filename}
    done
    echo
    echo
else
    cat scenery_list.txt | parallel --bar -n 1 -I {} -j 8 "unzip -u -n -qq {} -d {.}"
    echo
    echo
fi

