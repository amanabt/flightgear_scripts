#!/bin/bash

source "../scripts/progress_bar.sh"
source "../scripts/text_formatting.sh"

printf "${BRed}Updating packages from FlightGear Aircraft list\n"
printf "${Color_Off}See: http://mirrors.ibiblio.org/flightgear/ftp/Aircraft/\n"

echo -n "HTTP Proxy(Press Enter for no proxy): "; read proxy
if ! [ -z $proxy ]; then

        echo -n "Port: "; read port
        proxy="http://$proxy:$port"
        echo -n "Username: "; read username
        if [[ $username != "" ]]; then
                echo -n "Password (Note: script breaks with passwords with special characters): "
                read -rs password
                echo
                username=$username
                password=$password
        fi
fi

STR="$(whereis parallel)"
echo $STR
IFS=':' read -ra IS_PARALLEL <<< "$STR"    #Convert string to array


STR="$(wc -l aircraft_list.txt)"
echo $STR
IFS=' ' read -ra TOTAL_AIRCRAFTS <<< "$STR"    #Convert string to array
i=0

if [ -z "${IS_PARALLEL[1]}" ]; then
    echo "GNU Parallel not found!"
    while read aircraft_name; do
            if ! [ -z $aircraft_name ]; then
                    wget --quiet -N --proxy-user="$username" --proxy-passwd="$password" \
                            -e use_proxy=on -e http_proxy="$proxy" \
                            http://mirrors.ibiblio.org/flightgear/ftp/Aircraft/$aircraft_name
            fi
            i=$((i + 1))
            ProgressBar ${i} ${TOTAL_AIRCRAFTS} ${aircraft_name}
    done <aircraft_list.txt
else
    echo "Using GNU Parallel (Note: script breaks with passwords with special characters)"
    cat aircraft_list.txt | parallel --bar -n 1 -I {} -j 8 " wget --quiet -N --proxy-user="$username" --proxy-passwd="$password" -e use_proxy=on -e http_proxy="$proxy" http://mirrors.ibiblio.org/flightgear/ftp/Aircraft/"{}""

fi

