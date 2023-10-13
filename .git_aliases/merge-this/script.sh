#!/bin/sh
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/_common.sh"

branch=$(git get-current-branch) &&
    git checkout master &&
    git merge --no-ff "$branch" &&
    git branch -D "$branch"
