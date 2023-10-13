### `git replace-with [branch]`

Resets the head of current branch to that of `[branch]`, then force deletes `[branch]`.

```bash
# Alias for:
git reset --hard [branch]
git branch -D [branch]
```
