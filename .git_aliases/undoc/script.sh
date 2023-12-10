#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

if [ $# -eq 0 ]; then
    git reset --soft HEAD~
elif [ $# -eq 1 ] && [ $1 == "-f" ]; then
    git reset --hard HEAD~
else
    echo Invalid parameters
    exit 1
fi
