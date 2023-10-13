#!/bin/sh
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

if [ $# -eq 1 ]; then
    git branch -d "$1" &&
        git push -d origin "$1"
else
    echo Invalid parameters
fi
