#!/bin/bash
set -eo pipefail
trap "exit 0" 2 15
function run_cmd {
  exec $*
}

function main {
  test -d "$SB_DATA" || mkdir -p "$SB_DATA"
  test -r "$SB_DATA/config.ini" || touch "$SB_DATA/config.ini"

  cd "$SB_HOME"
  git checkout $SICKRAGE_CHANNEL
  git pull
  run_cmd "python SickBeard.py -f --datadir=$SB_DATA --config=$SB_DATA/config.ini"
}

main
exit 0