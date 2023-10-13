### `git has-unmerged`

Checks if there's any unmerged paths, which somehow can occur when `.git/MERGE_HEAD` doesn't exist.
<br>_(eg. during merge conflicts after applying a stash)_
<br>_(Used in `git get-in-prog-cmd`)_

```bash
# Alias for:
git ls-files --unmerged | grep -q .

# Usage:
if git has-unmerged; then
...
```
