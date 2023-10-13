### `git unmerge`

Must be on a merge commit.
<br>Restore the deleted branch from the merge commit, and undo the merge commit.
<br>_(effectively undoing `git merge-this`)_

```bash
# Alias for:
git restore-deleted-branch HEAD
git undoc -f
git checkout -
```
