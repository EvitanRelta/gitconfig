### `git undoc [-f]`

Undo/Uncommit the last commit, keeping the commit's changes as staged.
<br> _(Force flag doesn't keep the commit's changes)_

```bash
# Alias for (w/o force flag):
git reset --soft HEAD~

# Alias for (force flag):
git reset --hard HEAD~
```
