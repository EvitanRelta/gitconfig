#!/bin/sh
aliases_root_dir="$(dirname "$0")/../.."
EXEC_IN_REPO_ROOT=true source "$aliases_root_dir/_common.sh"

test -d .git/rebase-merge
