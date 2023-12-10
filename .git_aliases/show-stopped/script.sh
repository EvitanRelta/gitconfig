#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

set -e

stopped_commit_hash="$(git get-stopped-hash)"
git show "$stopped_commit_hash"
