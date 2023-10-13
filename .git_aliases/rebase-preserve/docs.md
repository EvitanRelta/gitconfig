### `git rebase-preserve [same-options-as-rebase]`

Exactly the same as `rebase`, but preserves the author & committer dates of commits.

```bash
# Alias for:
git -c rebase.instructionFormat='%s%nexec GIT_COMMITTER_DATE=\"%cD\" git commit --amend --no-edit' rebase [same-options-as-rebase]

# Usage:
git rebase-preserve -i --rebase-merges @~5
```
