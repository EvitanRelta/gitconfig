#!/bin/sh
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

current_branch=$(git get-current-branch) &&
    git push -u origin $current_branch
