### `git is-reverting`

Checks if is currently reverting, by checking if the `.git/REVERT_HEAD` file exists.
<br>_(Used in `git get-in-prog-cmd`)_

```bash
# Usage:
if git is-reverting; then
...
```
