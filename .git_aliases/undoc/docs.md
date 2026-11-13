### `git undoc [-f]`

Undo/Uncommit the last commit, keeping the commit's changes as staged.
<br> _(Force flag doesn't keep the commit's changes)_

Also saves the last undone commit's hash to `.git/undoc_hash` (per repo) to be used by
the `redoc` alias.

```bash
# Alias for (w/o force flag):
git reset --soft HEAD~

# Alias for (force flag):
git reset --hard HEAD~
```
