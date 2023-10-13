#!/bin/sh
aliases_root_dir="$(dirname "$0")/../.."
source "$aliases_root_dir/.common.sh"

git rev-parse --abbrev-ref HEAD
