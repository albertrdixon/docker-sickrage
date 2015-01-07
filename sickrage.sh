#!/bin/sh
run_cmd(){
  exec $*
}

run_cmd "python /sickrage/SickBeard.py -f --datadir=$SB_DATA --config=$SB_DATA/config.ini"