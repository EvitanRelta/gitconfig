### `git unmerge`

Must be on a merge commit.
<br>Checks out to the deleted branch of the commit, and undo the merge commit.
<br>_(effectively undoing `git merge-this`)_

```bash
# Alias for:
git get-deleted-branch HEAD
git undoc -f
git checkout -
```
