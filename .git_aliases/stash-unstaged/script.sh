#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

git commit --quiet -m "TEMP (staged changes)" &&
    git stash -u "$@" &&
    git undoc