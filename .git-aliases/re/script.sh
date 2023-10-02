#!/bin/sh
. ~/.git-aliases/_common.sh

if [[ $* == *-i* ]]; then
    git rebase "$@"
else
    GIT_SEQUENCE_EDITOR=: git rebase -i "$@"
fi
