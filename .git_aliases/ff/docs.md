### `git ff [remote]`

Fast-forwards current branch to corresponding branch on `[remote]`.

```bash
# Alias for:
current_branch=$(git get-current-branch)
git fetch [remote]
git merge --ff-only [remote]/$current_branch
```
