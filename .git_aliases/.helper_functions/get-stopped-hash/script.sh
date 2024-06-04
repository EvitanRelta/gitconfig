#!/bin/bash
aliases_root_dir="$(dirname "$0")/../.."
EXEC_IN_REPO_ROOT=true source "$aliases_root_dir/.common.sh"

if git is-rebasing; then
    cat .git/rebase-merge/stopped-sha
else
    >&2 echo "Not currently rebasing"
    exit 1
fi
