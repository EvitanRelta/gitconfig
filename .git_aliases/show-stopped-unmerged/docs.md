### `git show-stopped-unmerged`

Shows the changes of the commit that the current rebase has stopped at,
specifically only for the currently unmerged files.

```bash
# Alias for:
unmerged_paths="$(git get-unmerged-paths)"
git show-stopped -- "$unmerged_paths"
```
