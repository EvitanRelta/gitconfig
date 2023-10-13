#!/bin/sh
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

git stash-unstaged --quiet &&
    git stash -u "$@" &&
    git stash pop --quiet stash@{1}
