#!/bin/bash

source "../scripts/progress_bar.sh"

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
IFS=':' read -ra IS_PARALLEL <<< "$STR"    #Convert string to array

STR="$(wc -l scenery_list.txt)"
IFS=' ' read -ra TOTAL_SCENERY <<< "$STR"    #Convert string to array
i=0

if [ -z "${IS_PARALLEL[1]}" ]; then
    echo "GNU Parallel not found!"
    while read scenery_name; do
            i=$((i + 1))
            ProgressBar ${i} ${TOTAL_SCENERY} ${scenery_name}
            if ! [ -z $scenery_name ]; then
                    wget --quiet -N --proxy-user="$username" --proxy-passwd="$password" \
                            -e use_proxy=on -e http_proxy="$proxy" \
                            http://ns334561.ip-5-196-65.eu/~fgscenery/WS2.0/$scenery_name
            fi
    done <scenery_list.txt

else
    echo "Using GNU Parallel (Note: script breaks with passwords with special characters)"
    cat scenery_list.txt | parallel --bar -n 1 -I {} -j 8 " wget --quiet -N --proxy-user=$username --proxy-passwd=$password -e use_proxy=on -e http_proxy=$proxy http://ns334561.ip-5-196-65.eu/~fgscenery/WS2.0/'{}' "

fi

