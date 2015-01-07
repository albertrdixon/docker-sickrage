#!/bin/bash
set -eo pipefail
trap "exit 0" 2 15
function run_cmd {
  exec $*
}

function main {
  local cmd="$@"
  if [ -z "$cmd" ] || [[ "$cmd" == "sickrage" ]]; then
    cmd="python $SB_HOME/SickBeard.py -f --datadir=$SB_DATA --config=$SB_DATA/config.ini"
  fi
  test -d "$SB_DATA" || mkdir -p "$SB_DATA"
  test -r "$SB_DATA/config.ini" || envtpl --keep-template -o "$SB_DATA/config.ini" /templates/config.ini.tpl

  cd "$SB_HOME"
  git checkout $SICKRAGE_CHANNEL
  git pull
  run_cmd "$cmd"
}

main "$@"
exit 0