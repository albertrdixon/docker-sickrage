#!/bin/bash
set -eo pipefail
trap "exit 0" 2 15
function run_cmd {
  exec $*
}

function main {
  test -e "$SB_DATA" || { echo "Cannot find data dir: $SB_DATA"; exit 1; }
  test -r $"SB_CONFIG" || touch $SB_CONFIG 

  cd "$SB_HOME"
  git pull
  run_cmd "python SickBeard.py -f --datadir=$SB_DATA --config=$SB_CONFIG"
}

main
exit 0