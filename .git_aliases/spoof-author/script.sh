#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

GIT_COMMITTER_NAME="$1" GIT_COMMITTER_EMAIL="$2" git commit --amend --no-edit --author="$1 <$2>"
