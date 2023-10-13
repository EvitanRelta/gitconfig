#!/bin/sh
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

if [ $# -eq 1 ] && [ $1 != "-f" ]; then
    git remote add origin "$1" &&
        git remote set-url origin "$1" &&
        git push -u origin master
elif [ $# -eq 2 ] && [ $1 == "-f" ]; then
    git remote add origin "$2" &&
        git remote set-url origin "$2" &&
        git push -uf origin master
else
    echo Invalid parameters
fi
