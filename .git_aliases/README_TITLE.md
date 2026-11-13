## Setup

The steps below is for creating symlinks in the system root, targeting the config files in this repo.

Specifically, it'll create these symlinks:

```bash
# In root: ~/
.git_aliases@    --> gitconfig/.git_aliases
.gitconfig@      --> gitconfig/.gitconfig
.vim@            --> gitconfig/.vim
.vimrc@          --> gitconfig/.vimrc
```

It also appends a line to `~/.bashrc` and `~/.inputrc` that loads this repo's `.bashrc`/`.inputrc`,
and writes `~/.bash_profile` to load `~/.profile` (if present) and `~/.bashrc`.

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

### Optional: `git-graph`

`git graph` uses [git-graph](https://github.com/git-bahn/git-graph) if it's installed, otherwise it falls back to the `git log --graph` alias.

1. Install version 0.8.3 or newer: `cargo install git-graph --locked`, or download a binary from its [releases](https://github.com/git-bahn/git-graph/releases) into somewhere on your `PATH` (e.g. `~/.local/bin/`)
2. Open a new terminal, then check that `type -a git-graph` lists `gitconfig/bin/git-graph` first

`bin/git-graph` is a wrapper that pages the output through `less` (git-graph dropped its built-in pager in v0.8.0). The repo's `.bashrc` puts `bin/` at the front of `PATH`, so the `source .../gitconfig/.bashrc` line must stay at the bottom of `~/.bashrc`, below anything else that adds to `PATH`.

<br>

## Git Aliases

