### `git branch-exists [branch]`

Checks if branch `[branch]` exists.
<br>_(Used in conditional statements for other aliases)_

```bash
# Alias for:
git show-ref --quiet "refs/heads/[branch]"

# Usage:
if git branch-exists my-branch; then
...
```
