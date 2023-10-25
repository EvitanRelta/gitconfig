#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

GIT_COMMITTER_DATE="$2" git commit --date="$1" --amend --no-edit
