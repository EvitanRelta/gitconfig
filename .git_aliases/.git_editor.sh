#!/bin/bash

# Use VS Code when called from its integrated terminal (where `code` opens the
# file in that same window, including WSL/SSH remotes), else Vim.
if [[ "$TERM_PROGRAM" == "vscode" ]] && command -v code > /dev/null 2>&1; then
    code --wait "$@"
else
    vim "$@"
fi
