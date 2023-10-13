#!/bin/sh
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

in_prog_cmd="$(git get-in-prog-cmd)" &&
    echo "Continuing $in_prog_cmd (no edit)..." &&
    eval "git -c core.editor=true $in_prog_cmd --continue"
