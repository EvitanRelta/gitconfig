#!/bin/bash

if [[ -n "$WSL_DISTRO_NAME" ]]; then
    # If in WSL, resolve the "$LOCALAPPDATA" variable and translate WSL paths to
    # regular Windows paths.
    LOCALAPPDATA=$(wslpath "$(cmd.exe /c "<nul set /p=%LOCALAPPDATA%" 2>/dev/null)")
    set -- $(wslpath -w "$@")
    VSCODE_EDITOR_PATH="$LOCALAPPDATA/Programs/Microsoft VS Code/bin/code"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    # For native Windows (Git Bash/Cygwin)
    VSCODE_EDITOR_PATH="$LOCALAPPDATA/Programs/Microsoft VS Code/bin/code"
else
    # For Linux/SSH environments, try to find VSCode in PATH
    VSCODE_EDITOR_PATH=$(which code 2>/dev/null)
fi


# Use VSCode as editor if it exists, else use Vim.
if command -v "$VSCODE_EDITOR_PATH" > /dev/null 2>&1; then
    "$VSCODE_EDITOR_PATH" --wait "$@"
else
    vim "$@"
fi
