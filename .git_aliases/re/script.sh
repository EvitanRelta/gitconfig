#!/bin/sh
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/_common.sh"

if [[ $* == *-i* ]]; then
    git rebase "$@"
else
    GIT_SEQUENCE_EDITOR=: git rebase -i "$@"
fi
