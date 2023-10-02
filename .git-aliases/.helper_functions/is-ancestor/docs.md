### `git is-ancestor [older_commit/branch] [newer_commit/branch]`

Checks if `[older_commit/branch]` is an ancestor of `[newer_commit/branch]`.
<br>_(Used in conditional statements for other aliases)_

```bash
# Alias for:
git merge-base --is-ancestor [older_commit/branch] [newer_commit/branch]

# Usage:
if git branch-exists origin/master HEAD; then
...
```
