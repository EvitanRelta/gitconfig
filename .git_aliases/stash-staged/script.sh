#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"
set -e

git stash-unstaged --quiet
git stash -u "$@"
git stash pop --quiet stash@{1}
