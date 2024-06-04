#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

last_undone_hash_save_path="$(realpath "$aliases_root_dir/../undoc_hash.temp")"

# Check if the file exists.
if [ ! -f "$last_undone_hash_save_path" ]; then
    echo "No undone commit hash found at $last_undone_hash_save_path"
    exit 1
fi

read hash < "$last_undone_hash_save_path"
git commit -c "$hash" --no-edit
