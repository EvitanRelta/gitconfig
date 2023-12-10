#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"
set -e

current_branch="$(git get-current-branch)"
git fetch "$1"
git merge --ff-only "$1/$current_branch"
