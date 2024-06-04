#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"
set -e

if [ $# -ne 1 ]; then
    echo Invalid parameters
    exit 1
fi

current_branch=$(git get-current-branch)
git checkout "$1"
git reset --hard "$current_branch"
git branch -D "$current_branch"
