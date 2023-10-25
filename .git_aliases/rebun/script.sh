#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

GIT_SEQUENCE_EDITOR="perl -0777 -i -pe 's/pick/$1/'" git rebase -i --rebase-merges "$2"~
