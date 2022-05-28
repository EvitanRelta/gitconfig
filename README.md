## Git Aliases

### `git cum [flags/parameters]`

```bash
# Alias for:
git add .
git commit [flags/parameters]
```

<br>

### `git cumane`

```bash
# Alias for:
git add .
git commit --amend --no-edit
```

<br>

### `git cane`

```bash
# Alias for:
git commit --amend --no-edit
```

<br>

### `git dump`

Dumps any unstaged changes.

```bash
# Alias for:
git restore .
git clean -df
```

<br>

### `git undoc`

Undo/Uncommit the last commit.

```bash
# Alias for:
git reset --soft HEAD^
```

<br>

### `git stat`

```bash
# Alias for:
git status
```

<br>

### `git pop`

```bash
# Alias for:
git stash pop
```

<br>

### `git rebun [interactve_command] [commit_hash]`

Rebases a single commit without opening interactive editor.
<br> `[interactive_command]` is the `pick/edit/reword/fix` etc. command in the interactive editor.

```bash
# Alias for:
git rebase -i [commit_hash]
# Then replacing the 'pick' of the oldest commit to [interactive_command]

# Example ussage:
git rebun edit HEAD~3
git rebun e 2ea1622
git rebun reword HEAD~4
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
git stash --quiet --staged
git stash -u [flags/parameters]
git stash pop --quiet "stash@{1}"
```

<br>

### `git stash-staged [flags/parameters]`

Stashes staged changes, leaving behind unstaged changes.

```bash
# Alias for:
git stash-unstaged -q
git stash -u [flags/parameters]
git stash pop -q "stash@{1}"
```

<br>

### `git pull-all-branches`

Pulls all remote branches.

> Source: https://stackoverflow.com/questions/10312521/how-to-fetch-all-git-branches#answer-10312587

```bash
# Alias for:
git fetch -p    # Update + prune remote branches
for remote in `git branch -r | grep -v " -> "`; do
    git branch --track ${remote#origin/} $remote
done
git fetch --all
git pull --all
```

<br>

### `git pull-force`

Pulls and overwrite current local branch.

```bash
# Alias for:
git fetch --all
git reset --hard "origin/$(git branch --show-current)"
```