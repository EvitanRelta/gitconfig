#!/bin/bash
aliases_root_dir="$(dirname "$0")/../.."
EXEC_IN_REPO_ROOT=true source "$aliases_root_dir/.common.sh"

test -e .git/CHERRY_PICK_HEAD
