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

while read aircraft_name; do
	echo "$aircraft_name"
	if ! [ -z $aircraft_name ]; then
		wget -N --proxy-user=$username --proxy-passwd=$password \
			-e use_proxy=on -e http_proxy=$proxy \
			http://mirrors.ibiblio.org/flightgear/ftp/Aircraft/$aircraft_name
	fi
done <aircraft_list.txt

