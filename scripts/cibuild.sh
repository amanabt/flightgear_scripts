#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

ls -al /usr/share/games/flightgear/

##############################
# Testing without GNU Parallel
##############################
yes '' | ./scripts/run_install.sh
./scripts/install_GNU_parallel.sh
yes '' | ./scripts/run_install.sh

unset DEBIAN_FRONTEND=noninteractive
