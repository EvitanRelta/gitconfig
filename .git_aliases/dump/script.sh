#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

if [ $# -eq 0 ]; then
    git restore :/ &&
        git clean -df :/
elif [ $# -eq 1 ] && [ "$1" == "-f" ]; then
    git reset --quiet &&
        git restore :/ &&
        git clean -df :/
else
    echo Invalid parameters
    exit 1
fi
