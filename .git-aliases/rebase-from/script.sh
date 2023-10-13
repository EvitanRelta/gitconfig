#!/bin/sh
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/_common.sh"

if [ $# -ne 2 ]; then
    echo Invalid parameters
    exit 1
fi
current_branch=$(git get-current-branch) &&
    git re --onto "$2" "$1~" $current_branch
