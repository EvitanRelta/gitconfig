#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

# Stored per repo (inside its .git dir) so `redoc` in another repo can't pick it up
last_undone_hash_save_path="$(git rev-parse --absolute-git-dir)/undoc_hash" || exit 1

if [ $# -eq 0 ]; then
    git get-current-hash > "$last_undone_hash_save_path"
    git reset --soft HEAD~
elif [ $# -eq 1 ] && [ $1 == "-f" ]; then
    git get-current-hash > "$last_undone_hash_save_path"
    git reset --hard HEAD~
else
    echo Invalid parameters
    exit 1
fi
