#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"


is_merge_commit="$(git rev-parse --verify "HEAD^2" 2> /dev/null)"
if [ -n "$is_merge_commit" ]; then
    git restore-deleted-branch HEAD &&
        git undoc -f &&
        git checkout -
else
    echo HEAD is not a merge commit
fi
