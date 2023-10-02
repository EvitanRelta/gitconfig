### `git rebase-from [inclusive_from_commit] [new_base]`

Rebase the current branch onto `[new_base]` starting from (and including) `[inclusive_from_commit]`.
<br>_(similar to `git rebase [new_base]` but only picking commits from `HEAD` up to `[inclusive_from_commit]`)_
<br>_(uses the `re` alias instead of `rebase`, to force autosquash)_

```bash
# Alias for:
current_branch=$(git get-current-branch)
git re --onto [new_base] [inclusive_from_commit]~ $current_branch
```
