#!/bin/sh
set -e

: ${SB_USER:=root}
: ${SB_HOME:=/sickrage}
: ${SB_PORT:=8081}
: ${SB_DATA:=/sickrage}
: ${SB_CONFIG:=/sickrage/config.ini}

test -e $SB_DATA || { echo "Cannot find data dir: $SB_DATA"; exit 1; }
test -r $SB_CONFIG || touch $SB_CONFIG 

cd $SB_HOME
git pull
exec "python" "SickBeard.py" "-f" "--datadir=$SB_DATA" "--config=$SB_CONFIG"