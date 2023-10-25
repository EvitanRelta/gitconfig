#!/bin/bash

VSCODE_EDITOR_PATH="$LOCALAPPDATA\\Programs\\Microsoft VS Code\\bin\\code"

# Use VSCode as editor if it exists, else use Vim.
if command -v "$VSCODE_EDITOR_PATH" > /dev/null 2>&1; then
    "$VSCODE_EDITOR_PATH" --wait "$@"
else
    vim "$@"
fi

