#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"
set -e

is_merge_commit="$(git rev-parse --verify "HEAD^2" 2> /dev/null)"
if [ -n "$is_merge_commit" ]; then
    restored_branch_name="$(git restore-deleted-branch HEAD)"
    git undoc -f
    git checkout "$restored_branch_name"
else
    echo HEAD is not a merge commit
    exit 1
fi
