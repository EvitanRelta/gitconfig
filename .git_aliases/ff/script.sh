#!/bin/sh
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

current_branch=$(git get-current-branch) &&
    git fetch "$1" &&
    git merge --ff-only "$1/$current_branch"
