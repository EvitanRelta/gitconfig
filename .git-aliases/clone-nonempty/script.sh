#!/bin/sh
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/_common.sh"

if [ $# -eq 2 ] && [ $1 != "-f" ]; then
    mkdir -p "$2" &&
        cd "$2" &&
        git init &&
        git remote add origin "$1" &&
        git fetch &&
        git checkout -t origin/master
elif [ $# -eq 3 ] && [ $1 == "-f" ]; then
    mkdir -p "$3" &&
        cd "$3" &&
        rm -drf .git &&
        git init &&
        git remote add origin "$2" &&
        git fetch &&
        git checkout -tf origin/master
else
    echo Invalid parameters
fi