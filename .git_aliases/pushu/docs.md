### `git pushu`

Push (and setup to track) to the same branch-name on origin.

```bash
# Alias for:
current_branch=$(git get-current-branch)
git push -u origin $current_branch
```
