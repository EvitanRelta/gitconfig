### `git is-rebasing`

Checks if is currently rebasing, by checking if the `.git/rebase-merge` folder exists.
<br>_(Used in `git get-in-prog-cmd`)_

```bash
# Usage:
if git is-rebasing; then
...
```
