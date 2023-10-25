## Setup

The steps below is for creating symlinks in the system root, targeting the config files in this repo.

Specifically, it'll create these symlinks:

```bash
# In root: ~/
.bash_profile@   --> gitconfig/.bash_profile
.bashrc@         --> gitconfig/.bashrc
.git_aliases@    --> gitconfig/.git_aliases
.gitconfig@      --> gitconfig/.gitconfig
.vim@            --> gitconfig/.vim
.vimrc@          --> gitconfig/.vimrc
```

<br>

### On Linux

```bash
git clone https://github.com/EvitanRelta/gitconfig
cd gitconfig
bash init.sh
```

<br>

### On Windows

1. Run Git Bash as administrator
2. Execute `export MSYS=winsymlinks:nativestrict` \
  _(this will allow creation of symlinks used in `init.sh`)_
3. Do the steps in the `On Linux` section above

> _Based on: https://stackoverflow.com/a/40914277_

<br>

## Git Aliases

