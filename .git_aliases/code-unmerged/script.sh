#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
EXEC_IN_REPO_ROOT=true source "$aliases_root_dir/.common.sh"

if git has-unmerged; then
    git get-unmerged-paths | xargs code
else
    >&2 echo "No unmerged paths"
    exit 1
fi
