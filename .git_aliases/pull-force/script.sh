#!/bin/sh
aliases_root_dir="$(dirname "$0")/.."
source "$aliases_root_dir/.common.sh"

git fetch &&
    git reset --hard "origin/$(git branch --show-current)"