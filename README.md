## Setup

The steps below is for creating symlinks in the system root, targeting the config files in this repo.

Specifically, it'll create these symlinks:

```bash
# In root: ~/
.bash_profile@   --> gitconfig/.bash_profile
.bashrc@         --> gitconfig/.bashrc
.git_aliases@    --> gitconfig/.git_aliases
.gitconfig@      --> gitconfig/.gitconfig
.vim@            --> gitconfig/.vim
.vimrc@          --> gitconfig/.vimrc
```

<br>

### On Linux

```bash
git clone https://github.com/EvitanRelta/gitconfig
cd gitconfig
bash init.sh
```

<br>

### On Windows

1. Run Git Bash as administrator
2. Execute `export MSYS=winsymlinks:nativestrict` \
  _(this will allow creation of symlinks used in `init.sh`)_
3. Do the steps in the `On Linux` section above

> _Based on: https://stackoverflow.com/a/40914277_

<br>

## Git Aliases

### `git ab`

Aborts the current rebase/merge/cherry-pick/revert command.

```bash
# Alias for:
in_prog_cmd="$(git get-in-prog-cmd)"
    && echo "Aborting $in_prog_cmd..."
    && eval "git $in_prog_cmd --abort"
```

<br>

### `git addf [filenames]`

Fuzzy add filenames.

Prefix and suffix each filename with `*` to match every file that contains the
keyword.

```bash
# Alias for:
fuzzy_filenames=$(echo "$@" | sed -E "s/([^ ]+)/\*\\1\*/g")
git add "$fuzzy_filenames"
```

<br>

### `git addn [file_paths]`

Negative add. Adds everything except the specified file(s).

```bash
# Alias for:
git add -A
git reset [file_paths]

# Usage:
git addn ./file1 ./dir/file2
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

### `git cane`

```bash
# Alias for:
git commit --amend --no-edit
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

# Alias for (force flag):
# Force overwrite any conflicting files
...
git checkout -tf origin/master

# Example usage:
git clone-nonempty -f https://github.com/EvitanRelta/my-repo .
```

<br>

### `git code-unmerged`

Open all unmerged files in VSCode editor via the `code` command.

For example, if `FILE1`, `PATH/TO/FILE2` and `../FILE3` are unmerged,
this command runs:

```bash
code "FILE1"
code "PATH/TO/FILE2"
code "../FILE3"
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

Continues the current rebase/merge/cherry-pick/revert command while preventing the prompt for editing the commit message.
<br>_(similar to `--no-edit` flag for `git commit`)_

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

### `git delete-this`

Deletes the current branch, checking out to previous branch.

```bash
# Alias for:
current_branch=$(git get-current-branch)
git checkout -
git branch -D $current_branch
```

<br>

### `git diffst [flags/parameters]`

Prints the diff of staged files.

```bash
# Alias for:
git diff --staged [flags/parameters]
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

### `git f [commit_hash]`

Commit-fixup targeting `[commit_hash]`.

```bash
# Alias for:
git commit --fixup=[commit_hash]
```

<br>

### `git ff [remote]`

Fast-forwards current branch to corresponding branch on `[remote]`.

```bash
# Alias for:
current_branch=$(git get-current-branch)
git fetch [remote]
git merge --ff-only [remote]/$current_branch
```

<br>

### `git git [commands/flags/parameters]`

For when you accidentally type `git` twice.

```bash
# Alias for:
git [commands/flags/parameters]
```

<br>

### `git graph`

Displays Git commit graph.

```bash
# Alias for:
git log \
  --graph \
  --abbrev-commit \
  --decorate \
  --all \
  --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'
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

### `git merge-this`

Merge _(no fast-forward)_ current branch _(ie. `[branch_name]`)_ to master, and deletes it locally.

```bash
# Alias for:
git checkout master
git merge --no-ff --no-edit [branch_name]
git branch -D [branch_name]
```

<br>

### `git pop [flags/parameters]`

```bash
# Alias for:
git stash pop [flags/parameters]
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

### `git pull-pr [username]:[branch] [optional_remote_name]`

Pulls (and checkout to) a PR's branch. The `[username]:[branch]` is given in
the GitHub's PR description.

If no remote with a URL containing `[username]` exists, create a new remote
named `[username]` (or `[optional_remote_name]` if given) with a URL based on
`origin` remote. \
_(eg. If `origin  https://github.com/EvitanRelta/repo` then the URL will be `https://github.com/[username]/repo`)_

If a remote exists, but it's name isn't equal to `[optional_remote_name]`, then
that remote is renamed to `[optional_remote_name]`.

For example, for the PR description: \
"afiqzu wants to merge 1 commit into `CS3219-AY2324S1:assignment-5` from `afiqzu:assignment-5`" \
`[username]:[branch]` = `afiqzu:assignment-5`

```bash
# Given this scenario:
$ git remote -v
oldremote  https://github.com/EvitanRelta/repo
origin     https://github.com/myorigin/repo
```

#### Example usage 1:
```bash
git pull-pr EvitanRelta:pr-branch
# is alias for:
git fetch oldremote
git checkout -b oldremote-pr-branch oldremote/pr-branch
```

#### Example usage 2:
```bash
git pull-pr EvitanRelta:pr-branch newremote
# is alias for:
git remote rename oldremote newremote
git fetch newremote
git checkout -b newremote-pr-branch newremote/pr-branch
```

#### Example usage 3:
```bash
git pull-pr NewUser:pr-branch newremote
# is alias for:
git remote add newremote https://github.com/NewUser/repo
git fetch newremote
git checkout -b newremote-pr-branch newremote/pr-branch
```

<br>

### `git pushu`

Push (and setup to track) to the same branch-name on origin.

```bash
# Alias for:
current_branch=$(git get-current-branch)
git push -u origin $current_branch
```

<br>

### `git push-until [commit]`

Push all commits until (and including) `[commit]` to the `origin` branch of
the same name.

```bash
# Alias for:
current_branch="$(git get-current-branch)"
git push origin "[commit]:$current_branch"
```

<br>

### `git re [flags/parameters]`

Alias for rebase.
<br>But if no `-i` or `--interactive` is given, it will pass the `interactive` flag along with a noop editor.
<br>_(this is to force autosquash, which for some reason doesn't run without interactive)_

```bash
# Alias for (if interactive flag given):
git rebase [flags/parameters]

# Alias for (if no interactive flag given):
GIT_SEQUENCE_EDITOR=: git rebase -i [flags/parameters]
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

### `git rebase-preserve [same-options-as-rebase]`

Exactly the same as `rebase`, but preserves the author & committer dates of commits.

```bash
# Alias for:
git -c rebase.instructionFormat='%s%nexec GIT_COMMITTER_DATE=\"%cD\" git commit --amend --no-edit' rebase [same-options-as-rebase]

# Usage:
git rebase-preserve -i --rebase-merges @~5
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

### `git redoc`

Commit using the last undone (via `undoc` alias) commit's message.

```bash
# Alias for:
git commit -c [last_undone_commit] --no-edit
```

<br>

### `git replace-that [branch]`

Replaces `[branch]` (ie. "that" branch) with current branch, then force deletes
current branch while checking out to `[branch]`.

```bash
# Alias for:
current_branch=$(git get-current-branch)
git checkout [branch]
git reset --hard "$current_branch"
git branch -D "$current_branch"
```

<br>

### `git replace-this [branch]`

Replaces current branch (ie. "this" branch) with `[branch]`, then force deletes `[branch]`.

```bash
# Alias for:
git reset --hard [branch]
git branch -D [branch]
```

<br>

### `git show-stopped [flags/parameters]`

Shows the changes of the commit that the current rebase has stopped at.

```bash
# Alias for:
stopped_commit_hash="$(git get-stopped-hash)"
git show "$stopped_commit_hash" [flags/parameters]
```

<br>

### `git show-stopped-unmerged`

Shows the changes of the commit that the current rebase has stopped at,
specifically only for the currently unmerged files.

```bash
# Alias for:
unmerged_paths="$(git get-unmerged-paths)"
git show-stopped -- "$unmerged_paths"
```

<br>

### `git spoof-author [name] [email]`

Changes the author/commiter names and emails of the previous commit.

```bash
# Alias for:
GIT_AUTHOR_NAME="[name]" GIT_AUTHOR_EMAIL="[email]" GIT_COMMITTER_NAME="[name]" GIT_COMMITTER_EMAIL="[email]" git commit --amend --no-edit
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

<br>

### `git st [flags/parameters]`

```bash
# Alias for:
git status [flags/parameters]
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

### `git stash-unstaged [flags/parameters]`

Stashes unstaged (and untracked) changes, leaving behind staged changes.

```bash
# Alias for:
git commit --quiet -m "TEMP (staged changes)"
git stash -u [flags/parameters]
git undoc
```

<br>

### `git undoc [-f]`

Undo/Uncommit the last commit, keeping the commit's changes as staged.
<br> _(Force flag doesn't keep the commit's changes)_

Also saves the last undone commit's hash to `undoc_hash.temp` to be used by the
`redoc` alias.

```bash
# Alias for (w/o force flag):
git reset --soft HEAD~

# Alias for (force flag):
git reset --hard HEAD~
```

<br>

### `git unmerge`

Must be on a merge commit.
<br>Restore the deleted branch from the merge commit, and undo the merge commit.
<br>_(effectively undoing `git merge-this`)_

```bash
# Alias for:
git restore-deleted-branch HEAD
git undoc -f
git checkout -
```

<br>

## Helper functions

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

### `git get-stopped-hash`


Gets the hash of the commit that the current rebase has stopped at.
<br>_(Used in other aliases)_

```bash
# Alias for:
cat .git/rebase-merge/stopped-sha
```

<br>

### `git get-unmerged-paths`

Gets all the unmerged file paths, relative to the current dir.
<br>For example, user is in `/A/`, unmerged file at `/B/FILE`, return `../B/FILE`.
<br>_(Used in other aliases)_

```bash
# Alias for:
git diff --name-only --diff-filter=U
# Then convert to be relative to current dir.
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

### `git is-cherry-picking`

Checks if is currently cherry-picking, by checking if the `.git/CHERRY_PICK_HEAD` file exists.
<br>_(Used in `git get-in-prog-cmd`)_

```bash
# Usage:
if git is-cherry-picking; then
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

### `git is-rebasing`

Checks if is currently rebasing, by checking if the `.git/rebase-merge` folder exists.
<br>_(Used in `git get-in-prog-cmd`)_

```bash
# Usage:
if git is-rebasing; then
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

### `git restore-deleted-branch [merge_commit_hash]`

Restores a locally-deleted branch from a merge commit, and returns `[branch_name]`.

Infers the deleted `[branch_name]` from the merge commit's subject.
<br>_(expects the merge commit's subject to be in the form: "Merge branch '`[branch_name]`' ...")_

```bash
# Alias for:
git branch [branch_name] [merge_commit_hash]^2
echo [branch_name]
```
