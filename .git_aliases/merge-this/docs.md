### `git merge-this`

Merge _(no fast-forward)_ current branch _(ie. `[branch_name]`)_ to master, and deletes it locally.

```bash
# Alias for:
git checkout master
git merge --no-ff --no-edit [branch_name]
git branch -D [branch_name]
```
