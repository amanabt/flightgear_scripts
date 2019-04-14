#!/bin/bash

source "../scripts/progress_bar.sh"

STR="$(whereis parallel)"
IFS=':' read -ra IS_PARALLEL <<< "$STR"    #Convert string to array

STR="$(wc -l aircraft_list.txt)"
IFS=' ' read -ra TOTAL_AIRCRAFT <<< "$STR"    #Convert string to array
i=0

if [ -z "${IS_PARALLEL[1]}" ]; then
    for filename in *.zip ; do
        i=$((i + 1))
        ProgressBar ${i} ${TOTAL_AIRCRAFT} ${filename}
    	yes | unzip -q $filename
    done
else
    echo "Using GNU Parallel (Note: script breaks with passwords with special characters)"
    cat aircraft_list.txt | parallel --bar -n 1 -I {} -j 8 "yes | unzip -q {}"
fi



