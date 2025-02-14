#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

committer_name=$(git show -s --format='%cn' "$1")
committer_email=$(git show -s --format='%ce' "$1")
committer_date=$(git show -s --format='%cd' "$1")
author=$(git show -s --format='%an <%ae>' "$1")
author_date=$(git show -s --format='%ad' "$1")

GIT_COMMITTER_NAME="$committer_name" \
GIT_COMMITTER_EMAIL="$committer_email" \
GIT_COMMITTER_DATE="$committer_date" \
git commit --amend --no-edit \
    --author="$author" \
    --date="$author_date"
