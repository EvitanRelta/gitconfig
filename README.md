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

### `git is-rebasing`

Checks if is currently rebasing, by checking if the `.git/rebase-merge` folder exists.
<br>_(Used in `git get-in-prog-cmd`)_

```bash
# Usage:
if git is-rebasing; then
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

### `git stash-staged [flags/parameters]`

Stashes staged changes, leaving behind unstaged changes.

```bash
# Alias for:
git stash-unstaged --quiet
git stash -u [flags/parameters]
git stash pop --quiet "stash@{1}"
```

<br>

### `git pull-force`

Pulls and overwrite current local branch.

```bash
# Alias for:
git fetch
git reset --hard "origin/$(git branch --show-current)"
```

<br>

### `git merge-this`

Merge _(no fast-forward)_ current branch _(ie. `[branch_name]`)_ to master, and deletes it locally.

```bash
# Alias for:
git checkout master
git merge --no-ff [branch_name]
git branch -D [branch_name]
```

<br>

### `git branch-d-both [branch_name]`

Deletes branch both locally and on remote.

```bash
# Alias for:
git branch -d [branch_name]
git push -d origin [branch_name]
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

### `git unmerge`

Must be on a merge commit.
<br>Checks out to the deleted branch of the commit, and undo the merge commit.
<br>_(effectively undoing `git merge-this`)_

```bash
# Alias for:
git get-deleted-branch HEAD
git undoc -f
git checkout -
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

<br>

### `git rebase-from [inclusive_from_commit] [new_base]`

Rebase the current branch onto `[new_base]` starting from (and including) `[inclusive_from_commit]`.
<br>_(similar to `git rebase [new_base]` but only picking commits from `HEAD` up to `[inclusive_from_commit]`)_
<br>_(uses the `re` alias instead of `rebase`, to force autosquash)_

```bash
# Alias for:
current_branch=$(git get-current-branch)
git re --onto [new_base] [inclusive_from_commit]~ $current_branch
```

<br>

### `git replace-with [branch]`

Resets the head of current branch to that of `[branch]`, then force deletes `[branch]`.

```bash
# Alias for:
git reset --hard [branch]
git branch -D [branch]
```

<br>

### `git rebase-preserve [same-options-as-rebase]`

Exactly the same as `rebase`, but preserves the author & committer dates of commits.

```bash
# Alias for:
git -c rebase.instructionFormat='%s%nexec GIT_COMMITTER_DATE=\"%cD\" git commit --amend --no-edit' rebase [same-options-as-rebase]

# Usage:
git rebase-preserve -i --rebase-merges @~5
```

<br>

### `git spoof-dates [author-date] [committer-date]`

Changes the author/commiter dates of the previous commit.

```bash
# Alias for:
GIT_COMMITTER_DATE="[committer-date]" git commit --date="[author-date]" --amend --no-edit

# Usage:
git spoof-dates "Fri Dec 2 18:53:50 2022 +0800" "Fri Dec 2 18:54:09 2022 +0800"
```
