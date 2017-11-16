#!/usr/bin/env bash

gitroot=$(git rev-parse --show-toplevel)

if [ $? -eq 0 ]; then
  quickfix=${gitroot}/.git
  ghcid -o $quickfix/cabal.quickfix -c stack repl $@
else
  echo "Not in a git repo. Running plain stack repl"
  stack repl
fi
