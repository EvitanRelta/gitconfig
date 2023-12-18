#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

last_undone_hash_save_path="$(realpath "$aliases_root_dir/../undoc_hash.temp")"

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
