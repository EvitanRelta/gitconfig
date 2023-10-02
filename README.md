## Git Aliases

### `git get-in-prog-cmd`

If is currently rebasing, merging, cherry-picking or reverting, outputs `rebase`, `merge`, `cherry-pick` or `revert` respectively.
If not, exit with error, and output "Not currently rebasing, merging or cherry-picking" to `stderr`.
<br>_(Used to infer the continue/abort/etc. commands for rebasing/merging/cherry-picking/etc)_

```bash
# Alias for:
if git is-rebasing; then
    echo rebase
elif git is-merging; then
    echo merge
elif git is-cherry-picking; then
    echo cherry-pick
elif git is-reverting; then
    echo revert
else
    >&2 echo "Not currently rebasing, merging, cherry-picking nor reverting"
    exit 1
fi
```

<br>

### `git con`

Continues the current rebase/merge/cherry-pick/revert command.

```bash
# Alias for:
in_prog_cmd="$(git get-in-prog-cmd)"
    && echo "Continuing $in_prog_cmd..."
    && eval "git $in_prog_cmd --continue"
```

<br>

### `git cone`

Continues the current rebase/merge/cherry-pick/revert command while preventing the prompt for editing the commit message _(similar to `--no-edit` flag for `git commit`)_.

```bash
# Alias for:
in_prog_cmd="$(git get-in-prog-cmd)"
    && echo "Continuing $in_prog_cmd (no edit)..."
    && eval "git -c core.editor=true $in_prog_cmd --continue"
```

<br>

### `git conea`

Adds all unstaged changes, then continues the current rebase/merge/cherry-pick/revert command while preventing the prompt for editing the commit message.

```bash
# Alias for:
git add -A
git cone
```

<br>

### `git ab`

Aborts the current rebase/merge/cherry-pick/revert command.

```bash
# Alias for:
in_prog_cmd="$(git get-in-prog-cmd)"
    && echo "Aborting $in_prog_cmd..."
    && eval "git $in_prog_cmd --abort"
```
