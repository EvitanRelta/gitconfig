## Git Aliases

### `git cum [flags/parameters]`

```bash
# Alias for:
git add -A
git commit [flags/parameters]
```

<br>

### `git cumane`

```bash
# Alias for:
git add -A
git commit --amend --no-edit
```

<br>

### `git cane`

```bash
# Alias for:
git commit --amend --no-edit
```

<br>

### `git st`

```bash
# Alias for:
git status
```

<br>

### `git pop [flags/parameters]`

```bash
# Alias for:
git stash pop [flags/parameters]
```

<br>

### `git rebun [interactve_command] [commit_hash]`

Rebases a single commit _(with `--rebase-merges` flag)_ without opening interactive editor.
<br> `[interactive_command]` is the `pick/edit/reword/fix` etc. command in the interactive editor.

```bash
# Alias for:
git rebase -i --rebase-merges [commit_hash]~
# Then replacing the 'pick' of the oldest commit to [interactive_command]

# Example ussage:
git rebun edit HEAD~3
git rebun e 2ea1622
git rebun reword HEAD~4
```

<br>

### `git git [commands/flags/parameters]`

For when you accidentally type `git` twice.

```bash
# Alias for:
git [commands/flags/parameters]
```

<br>

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

### `git undoc [-f]`

Undo/Uncommit the last commit, keeping the commit's changes as staged.
<br> _(Force flag doesn't keep the commit's changes)_

```bash
# Alias for:
git reset --soft HEAD~

# Alias for (force flag):
git reset --hard HEAD~
```

<br>

### `git dump [-f]`

Dumps any unstaged changes.
<br> _(Force flag dumps staged changes too)_

> `:/` is to select all files, including files not in the current directory _(eg. "../../file.ext")_

```bash
# Alias for (w/o force flag):
git restore :/
git clean -df :/


# Alias for (force flag):
git reset
git restore :/
git clean -df :/
```

<br>

### `git link [-f] [github_repo_url]`

Links local repo to `[github_repo_url]`, by setting remote `origin` to url and set-upstream push.
<br> _(Force flag force-pushes local repo to remote)_

```bash
# Alias for (w/o force flag):
git remote add origin [github_repo_url]
git remote set-url origin [github_repo_url]
git push -u origin master


# Alias for (force flag):
...
git push -uf origin master
```

<br>

### `git clone-nonempty [-f] [github_repo_url] [clone_to_path]`

Clones repo into a non-empty dir.
<br> _(Force flag force overwrites any local files that conflicts with the repo files)_

```bash
# Alias for (w/o force flag):
mkdir -p [clone_to_path]
cd [clone_to_path]
git init
git remote add origin [github_repo_url]
git fetch
git checkout -t origin/master

# Alias for (w/o force flag):
# Force overwrite any conflicting files
...
git checkout -tf origin/master

# Example usage:
git clone-nonempty -f https://github.com/EvitanRelta/my-repo .
```

<br>

### `git stash-unstaged [flags/parameters]`

Stashes unstaged (and untracked) changes, leaving behind staged changes.

```bash
# Alias for:
git commit --quiet -m "TEMP (staged changes)"
git stash -u [flags/parameters]
git undoc
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

### `git pull-all [-s [ignore_branch_name] [ignore_branch_name] ...]`

Pulls all remote branches.
<br> `-s` skip-flag skips pulling `[ignore_branch_name]` remote branches.

```bash
# Alias for:
git fetch -p    # Update + prune remote branches
echo "From $(git remote get-url origin)"
for remote_branch in `git branch -r | grep -v " -> " | grep "origin/"`; do
    branch=${remote_branch#origin/}

    git fetch
        --update-head-ok            # Allows changes to current branch/HEAD
        origin "$branch:$branch"    # Updates branch
        2>&1                        # Fix 'fetch' not outputting to 'grep'
        | grep -v "From"            # Removes repeated "From [REMOTE_URL]"

    git branch --quiet -u "$remote_branch" "$branch"    # Sets upstream, as 'git fetch' doesn't
done

# '-s' skip-flag implementation too complicated to show
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
git branch -d [branch_name]
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

If is currently rebasing, merging or cherry-picking, outputs `rebase`, `merge` or `cherry-pick` respectively.
If not, exit with error, and output "Not currently rebasing, merging or cherry-picking" to `stderr`.
<br>_(Used to infer the continue/abort/etc. commands for rebasing/merging/cherry-picking/etc)_

```bash
# Alias for:
if git is-rebasing; then
    echo rebase
elif git is-cherry-picking; then
    echo cherry-pick
elif git is-merging; then
    echo merge
else
    >&2 echo "Not currently rebasing, merging or cherry-picking"
    exit 1
fi
```

<br>

### `git con`

Continues the rebase/cherry-pick/merge/etc. command.

```bash
# Alias for:
in_prog_cmd="$(git get-in-prog-cmd)"
    && echo "Continuing $in_prog_cmd..."
    && eval "git $in_prog_cmd --continue"
```

<br>

### `git cone`

Continues the rebase/cherry-pick/merge/etc. command and prevent editing the commit message _(similar to `--no-edit` flag for `git commit`)_.

```bash
# Alias for:
in_prog_cmd="$(git get-in-prog-cmd)"
    && echo "Continuing $in_prog_cmd (no edit)..."
    && eval "git -c core.editor=true $in_prog_cmd --continue"
```

<br>

### `git ab`

Aborts the rebase/cherry-pick/merge/etc. command.

```bash
# Alias for:
in_prog_cmd="$(git get-in-prog-cmd)"
    && echo "Aborting $in_prog_cmd..."
    && eval "git $in_prog_cmd --abort"
```

<br>

### `git rebase-from [new_base] [inclusive_from_commit]`

Rebase the current branch onto `[new_base]` starting from (and including) `[inclusive_from_commit]`.
<br>_(similar to `git rebase [new_base]` but only picking commits from `HEAD` up to `[inclusive_from_commit]`)_

```bash
# Alias for:
current_branch=$(git get-current-branch)
git rebase --onto [new_base] [inclusive_from_commit]~ $current_branch
```

<br>

### `git replace-with [branch]`

Resets the head of current branch to that of `[branch]`, then force deletes `[branch]`.

```bash
# Alias for:
git reset --hard [branch]
git branch -D [branch]
```
