### `git replace-that [branch]`

Replaces `[branch]` (ie. "that" branch) with current branch, then force deletes
current branch while checking out to `[branch]`.

```bash
# Alias for:
current_branch=$(git get-current-branch)
git checkout [branch]
git reset --hard "$current_branch"
git branch -D "$current_branch"
```
