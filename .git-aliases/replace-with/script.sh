#!/bin/sh
. ~/.git-aliases/_common.sh

if [ $# -ne 1 ]; then
    echo Invalid parameters
fi
git reset --hard "$1" &&
    git branch -D "$1"
