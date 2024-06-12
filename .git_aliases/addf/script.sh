#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

# Prefix and suffix each argument with an asterisk (*)
fuzzy_filenames=$(echo "$@" | sed -E "s/([^ ]+)/\*\\1\*/g")
git add "$fuzzy_filenames"
