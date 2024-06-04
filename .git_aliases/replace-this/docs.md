### `git replace-this [branch]`

Replaces current branch (ie. "this" branch) with `[branch]`, then force deletes `[branch]`.

```bash
# Alias for:
git reset --hard [branch]
git branch -D [branch]
```
