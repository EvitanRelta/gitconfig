# AGENTS.md

## Architecture

Dotfiles repo. `init.sh` symlinks everything into `~/`, then runs `git submodule update --init` for vim colors and `git update-index --skip-worktree .bash_profile`.

Key files: `.gitconfig`, `.bashrc`, `.bash_profile`, `.inputrc`, `.vimrc`, `.vim/`

## Git aliases

Each alias is a directory under `.git_aliases/<name>/` containing:
- `script.sh` — the executable (sources `.common.sh` for `--docs` flag handling and `GIT_PREFIX` cd)
- `docs.md` — documentation that gets assembled into root `README.md`

### Adding a new alias

1. Create `.git_aliases/<name>/script.sh` and `.git_aliases/<name>/docs.md` (use `.git_aliases/.template/` as a starting point)
2. Add an entry in `.gitconfig` under `[alias]`
3. Add bash completions in `.bashrc` if the alias takes arguments
4. Run `bash .git_aliases/generate_readme.sh` from within `.git_aliases/` to regenerate `README.md`

### Adding a new helper function

Same pattern but lives under `.git_aliases/.helper_functions/<name>/`.

## Critical details

- **README.md is auto-generated** — never edit it directly; run `generate_readme.sh` after changing any `docs.md`
- **`con_` directory** — Windows can't have folders named `con`, so the `con` alias lives in `con_/`
- **`undoc_hash.temp`** — tracked file used for state sharing between `undoc` and `redoc` aliases
- **`.vim/colors`** — symlink to `.vim/vim-colorschemes/colors` (created by `init.sh`); don't commit the symlink target
- **`.bash_profile`** — marked `--skip-worktree` by `init.sh`, so local changes are invisible to `git status`
- **`.git_aliases/.common.sh`** — sourced by all alias scripts; handles `--docs` flag display and `GIT_PREFIX` directory handling