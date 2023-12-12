#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"
set -e

unmerged_paths="$(git get-unmerged-paths)"
git show-stopped -- "$unmerged_paths"
