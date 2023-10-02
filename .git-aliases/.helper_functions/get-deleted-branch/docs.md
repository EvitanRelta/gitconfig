### `git get-deleted-branch [merge_commit_hash]`

Checks out a locally-deleted branch.

Gets the deleted `[branch_name]` from the merge commit's subject.
<br>_(expects the merge commit's subject to be in the form: "Merge branch '`[branch_name]`' ...")_

```bash
# Alias for:
git checkout -b [branch_name] [merge_commit_hash]^2
git checkout -   # Go back to previous branch
```
