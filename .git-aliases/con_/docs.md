### `git con`

Continues the current rebase/merge/cherry-pick/revert command.

```bash
# Alias for:
in_prog_cmd="$(git get-in-prog-cmd)"
    && echo "Continuing $in_prog_cmd..."
    && eval "git $in_prog_cmd --continue"
```
