#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"
set -e

branch="$(git get-current-branch)"
git checkout master
git merge --no-ff --no-edit "$branch"
git branch -D "$branch"
