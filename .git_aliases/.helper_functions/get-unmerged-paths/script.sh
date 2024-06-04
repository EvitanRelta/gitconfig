#!/bin/bash
aliases_root_dir="$(dirname "$0")/../.."
source "$aliases_root_dir/.common.sh"

git_root=$(git rev-parse --show-toplevel)

# Using `sed` to convert Linux-style path (eg. "/c/Users") to Unix-style (eg. "C:/Users").
# This is because `git_root` is in Unix-style, and `realpath` only works when they match.
current_dir=$(pwd | sed 's/^\/\([a-z]\)/\U\1:/')

# `git diff --name-only --diff-filter=U` gives paths relative to the repo root.
# This converts them to be relative to the current dir.
git diff --name-only --diff-filter=U | while read -r file; do
    realpath --relative-to="$current_dir" "$git_root/$file"
done
