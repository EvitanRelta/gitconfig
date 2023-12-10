### `git show-stopped`

Shows the changes of the commit that the current rebase has stopped at.

```bash
# Alias for:
stopped_commit_hash="$(git get-stopped-hash)"
git show "$stopped_commit_hash"
```
