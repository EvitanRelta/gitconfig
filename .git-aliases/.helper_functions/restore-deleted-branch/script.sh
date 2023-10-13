#!/bin/sh
aliases_root_dir="$(dirname "$0")/../.."
source "$aliases_root_dir/_common.sh"

if [ $# -eq 1 ]; then
    commit_subject=$(git log --format=%s -n 1 "$1") &&
        branch_name=$(grep -Po "(?<=')[^']+(?=')" <<< "$commit_subject" | head -1) &&
        git branch "$branch_name" "$1^2"
else
    echo Invalid parameters
fi
