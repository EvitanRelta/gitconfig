#!/bin/bash

# If in WSL, resolve the "$LOCALAPPDATA" variable and translate WSL paths to
# regular Windows paths.
if [[ -n "$WSL_DISTRO_NAME" ]]; then
    LOCALAPPDATA=$(wslpath "$(cmd.exe /c "<nul set /p=%LOCALAPPDATA%" 2>/dev/null)")
    set -- $(wslpath -w "$@")
fi

VSCODE_EDITOR_PATH="$LOCALAPPDATA/Programs/Microsoft VS Code/bin/code"


# Use VSCode as editor if it exists, else use Vim.
if command -v "$VSCODE_EDITOR_PATH" > /dev/null 2>&1; then
    "$VSCODE_EDITOR_PATH" --wait "$@"
else
    vim "$@"
fi
