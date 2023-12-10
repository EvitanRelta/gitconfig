#!/bin/bash
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"
set -e

in_prog_cmd="$(git get-in-prog-cmd)"
echo "Continuing $in_prog_cmd..."
eval "git $in_prog_cmd --continue"
