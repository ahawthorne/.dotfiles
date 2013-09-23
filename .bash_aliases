#!/bin/bash
alias whatismyip='curl ip.appspot.com'
alias ll='ls -la'
#alias gpw="apg -n20 -m20 -MNCLS -p7 -a1 -E \\\/\\\`\>\<\\\"\'\\\\ -b ~/bloomfile -r /usr/share/dict/words"
alias gpw="apg -n20 -m20 -MNCLS -p7 -a1 -E \\\/\\\`\>\<\\\"\'\\\\ -r /usr/share/dict/words"

function apg_bloom() {
  apgbfm -d /usr/share/dict/words  -f ~/bloomfile
  apgbfm -i ~/bloomfile
  apgbfm -A /usr/share/dict/words  -f ~/bloomfile
  apgbfm -i ~/bloomfile
}

function gvm() {
  gvim --remote-tab-silent $@
}


#function check_exit {
#  "$@" > /dev/null 2>&1
#  echo $?
#}
#
#function bungler {
#  CMD=$1
#  GO=$@
#  if [[ $(check_exit git rev-parse) -eq 0 ]]; then
#    RAILPATH=$(git rev-parse --show-toplevel)
#    if [[ -f ${RAILPATH}/bin/${CMD} ]]; then
#      ${RAILPATH}/bin/${GO}
#      return 0
#    fi
#  fi
#  if [[ $(check_exit type ${CMD} | grep function) -eq 1 ]]; then
#    ${GO}
#  else
#    echo "${CMD}: command not found..."
#    return 127
#  fi
#}
#
##define commands for use with rails
#RAILS_CMDS=(rails rake rspec cucumber pickler)
#
#for i in "${RAILS_CMDS[@]}"; do
#  eval "function $i { bungler $i \$@; }"
#done
