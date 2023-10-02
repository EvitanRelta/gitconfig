## Git Aliases

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
