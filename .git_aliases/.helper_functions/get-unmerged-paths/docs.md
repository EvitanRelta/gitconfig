### `git get-unmerged-paths`

Gets all the unmerged file paths, relative to the current dir.
<br>For example, user is in `/A/`, unmerged file at `/B/FILE`, return `../B/FILE`.
<br>_(Used in other aliases)_

```bash
# Alias for:
git diff --name-only --diff-filter=U
# Then convert to be relative to current dir.
```
