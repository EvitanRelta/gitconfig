#!/bin/bash
aliases_root_dir="$(dirname "$0")/../.."
source "$aliases_root_dir/.common.sh"
set -e

if [ $# -eq 1 ]; then
    commit_subject=$(git log --format=%s -n 1 "$1")
    branch_name=$(grep -Po "(?<=')[^']+(?=')" <<< "$commit_subject" | head -1)
    git branch "$branch_name" "$1^2"
    echo "$branch_name"
else
    echo Invalid parameters
    exit 1
fi
