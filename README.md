## Git Aliases

### `git get-current-branch`

Gets current branch name.
<br>_(Used in other aliases)_

```bash
# Alias for:
git rev-parse --abbrev-ref HEAD
```

<br>

### `git get-current-hash`

Gets current commit hash.
<br>_(Used in other aliases)_

```bash
# Alias for:
git rev-parse HEAD
```

<br>

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

<br>

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

<br>

### `git is-merging`

Checks if is currently merging, by checking if the `.git/MERGE_HEAD` file exists.
<br>_(Used in `git get-in-prog-cmd`)_

```bash
# Usage:
if git is-merging; then
...
```

<br>

### `git is-cherry-picking`

Checks if is currently cherry-picking, by checking if the `.git/CHERRY_PICK_HEAD` file exists.
<br>_(Used in `git get-in-prog-cmd`)_

```bash
# Usage:
if git is-cherry-picking; then
...
```

<br>

### `git is-reverting`

Checks if is currently reverting, by checking if the `.git/REVERT_HEAD` file exists.
<br>_(Used in `git get-in-prog-cmd`)_

```bash
# Usage:
if git is-reverting; then
...
```

<br>

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

<br>

### `git get-deleted-branch [merge_commit_hash]`

Checks out a locally-deleted branch.

Gets the deleted `[branch_name]` from the merge commit's subject.
<br>_(expects the merge commit's subject to be in the form: "Merge branch '`[branch_name]`' ...")_

```bash
# Alias for:
git checkout -b [branch_name] [merge_commit_hash]^2
git checkout -   # Go back to previous branch
```

<br>

### `git get-in-prog-cmd`

If is currently rebasing, merging, cherry-picking or reverting, outputs `rebase`, `merge`, `cherry-pick` or `revert` respectively.
If not, exit with error, and output "Not currently rebasing, merging or cherry-picking" to `stderr`.
<br>_(Used to infer the continue/abort/etc. commands for rebasing/merging/cherry-picking/etc)_

```bash
# Alias for:
if git is-rebasing; then
    echo rebase
elif git is-merging; then
    echo merge
elif git is-cherry-picking; then
    echo cherry-pick
elif git is-reverting; then
    echo revert
else
    >&2 echo "Not currently rebasing, merging, cherry-picking nor reverting"
    exit 1
fi
```

<br>

### `git con`

Continues the current rebase/merge/cherry-pick/revert command.

```bash
# Alias for:
in_prog_cmd="$(git get-in-prog-cmd)"
    && echo "Continuing $in_prog_cmd..."
    && eval "git $in_prog_cmd --continue"
```

<br>

### `git cone`

Continues the current rebase/merge/cherry-pick/revert command while preventing the prompt for editing the commit message _(similar to `--no-edit` flag for `git commit`)_.

```bash
# Alias for:
in_prog_cmd="$(git get-in-prog-cmd)"
    && echo "Continuing $in_prog_cmd (no edit)..."
    && eval "git -c core.editor=true $in_prog_cmd --continue"
```

<br>

### `git conea`

Adds all unstaged changes, then continues the current rebase/merge/cherry-pick/revert command while preventing the prompt for editing the commit message.

```bash
# Alias for:
git add -A
git cone
```

<br>

### `git ab`

Aborts the current rebase/merge/cherry-pick/revert command.

```bash
# Alias for:
in_prog_cmd="$(git get-in-prog-cmd)"
    && echo "Aborting $in_prog_cmd..."
    && eval "git $in_prog_cmd --abort"
```
