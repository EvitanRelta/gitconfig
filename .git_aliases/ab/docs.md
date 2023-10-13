### `git ab`

Aborts the current rebase/merge/cherry-pick/revert command.

```bash
# Alias for:
in_prog_cmd="$(git get-in-prog-cmd)"
    && echo "Aborting $in_prog_cmd..."
    && eval "git $in_prog_cmd --abort"
```
