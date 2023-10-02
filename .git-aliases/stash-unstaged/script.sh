#!/bin/sh
. ~/.git-aliases/_common.sh

git commit --quiet -m "TEMP (staged changes)" &&
    git stash -u "$@" &&
    git undoc