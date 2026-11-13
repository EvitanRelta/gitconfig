#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

# Saved by `undoc` in this repo's .git dir
last_undone_hash_save_path="$(git rev-parse --absolute-git-dir)/undoc_hash" || exit 1

# Check if the file exists.
if [ ! -f "$last_undone_hash_save_path" ]; then
    echo "No undone commit hash found at $last_undone_hash_save_path"
    exit 1
fi

read hash < "$last_undone_hash_save_path"
git commit -c "$hash" --no-edit
