#!/bin/bash

echo -n "HTTP Proxy: "; read proxy
if ! [ -z $proxy ]; then

        echo -n "Port: "; read port
        proxy="http://$proxy:$port"
        echo -n "username: "; read username
        if [[ $username != "" ]]; then
                echo -n "password: "
                read -s password
                echo
                username=$username
                password=$password
        fi
fi

echo $proxy

while read scenery_name; do
        echo "$scenery_name"
        if ! [ -z $scenery_name ]; then
                wget -N --proxy-user=$username --proxy-passwd=$password \
                        -e use_proxy=on -e http_proxy=$proxy \
                        http://ns334561.ip-5-196-65.eu/~fgscenery/WS2.0/$scenery_name
        fi
done <scenery_list.txt
