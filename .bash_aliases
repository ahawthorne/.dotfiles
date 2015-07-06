#!/bin/bash
alias whatismyip='curl ip.appspot.com'
alias ll='ls -la'
#alias gpw="apg -n20 -m20 -MNCLS -p7 -a1 -E \\\/\\\`\>\<\\\"\'\\\\ -b ~/bloomfile -r /usr/share/dict/words"
alias gpw="apg -n20 -m20 -MNCLS -p7 -a1 -E \\\/\\\`\>\<\\\"\'\\\\ -r /usr/share/dict/words"

alias rspecd="rspec --format documentation"
alias cucumberd="cucumber --format pretty"

alias pass="openssl rand -base64 27 | cut -c1-27"

function apg_bloom() {
  apgbfm -d /usr/share/dict/words  -f ~/bloomfile
  apgbfm -i ~/bloomfile
  apgbfm -A /usr/share/dict/words  -f ~/bloomfile
  apgbfm -i ~/bloomfile
}

function gvm() {
  gvim --remote-tab-silent $@
}
