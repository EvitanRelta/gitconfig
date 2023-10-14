### `git delete-this`

Deletes the current branch, checking out to previous branch.

```bash
# Alias for:
current_branch=$(git get-current-branch)
git checkout -
git branch -D $current_branch
```
