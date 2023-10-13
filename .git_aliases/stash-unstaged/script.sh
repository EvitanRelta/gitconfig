#!/bin/sh
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/_common.sh"

git commit --quiet -m "TEMP (staged changes)" &&
    git stash -u "$@" &&
    git undoc