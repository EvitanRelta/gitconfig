### `git ff [remote]`

Fast-forwards current branch.

- **No argument**: merges the upstream tracking branch (`@{u}`) with `--ff-only`. No fetch is performed.
- **With `[remote]`**: fetches from the remote and fast-forwards to `remote/branch`.

```bash
# Alias for:

# No argument:
git merge --ff-only @{u}

# With [remote]:
current_branch=$(git get-current-branch)
git fetch [remote]
git merge --ff-only [remote]/$current_branch
```
