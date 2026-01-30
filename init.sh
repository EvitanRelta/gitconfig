#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define an array of the files and directories to check
files_and_dirs=(.git_aliases/ .gitconfig .vim/ .vimrc)

# Array to store existing files and directories
exists=()

# Check if each file or directory exists in the root directory
for item in "${files_and_dirs[@]}"; do
    if [[ -e ~/"$item" ]]; then
        exists+=("$item")
    fi
done

# If any file or directory exists, prompt the user for confirmation
if [[ ${#exists[@]} -ne 0 ]]; then
    echo "These files/directories will be replaced: ${exists[@]}"
    read -p "Do you want to continue? (yes/no): " response
    if [[ "$response" != "yes" ]]; then
        echo "Operation aborted."
        exit 1
    fi
fi

# Remove any existing files/directories or symlinks from the user's home directory
for item in "${exists[@]}"; do
    # Check without trailing /
    base_item="${item%/}"

    if [[ -L ~/"$base_item" ]]; then
        # It's a symlink, remove it
        rm ~/"$base_item"
    elif [[ -e ~/"$base_item" ]]; then
        # It's an actual file or directory
        rm -rf ~/"$base_item"
    fi
done

# Create symlinks from the script's current directory to the user's home directory
for item in "${files_and_dirs[@]}"; do
    base_item="${item%/}"
    ln -s "$DIR/$base_item" ~/"$base_item"
done

# Append source command to .bashrc instead of replacing it
BASHRC_LINE="source $DIR/.bashrc"
if ! grep -qF "$BASHRC_LINE" ~/.bashrc 2>/dev/null; then
    echo -e "\n$BASHRC_LINE" >> ~/.bashrc
    echo "Added '$BASHRC_LINE' to ~/.bashrc"
else
    echo "'.bashrc' already sources '$DIR/.bashrc'"
fi

if [[ -L "$DIR/.vim/colors" ]]; then
    rm "$DIR/.vim/colors"
fi

ln -s "$DIR/.vim/vim-colorschemes/colors" "$DIR/.vim/colors"

# Append include statement to .inputrc instead of replacing it
INPUTRC_LINE="\$include $DIR/.inputrc"
if ! grep -qF "$INPUTRC_LINE" ~/.inputrc 2>/dev/null; then
    echo -e "\n$INPUTRC_LINE" >> ~/.inputrc
    echo "Added '$INPUTRC_LINE' to ~/.inputrc"
else
    echo "'.inputrc' already includes '$DIR/.inputrc'"
fi

echo "Symlinks created successfully."

# Create .bash_profile to source .bashrc for login shells
cat > ~/.bash_profile << 'EOF'
# Load `.bashrc` if it exists.
test -f ~/.bashrc && . ~/.bashrc
EOF

echo "Created ~/.bash_profile to source ~/.bashrc"

# Initialise `vim-colorschemes` submodule.
cd "$DIR"
git submodule update --init

