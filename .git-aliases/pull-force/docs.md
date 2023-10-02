### `git pull-force`

Pulls and overwrite current local branch.

```bash
# Alias for:
git fetch
git reset --hard "origin/$(git branch --show-current)"
```
