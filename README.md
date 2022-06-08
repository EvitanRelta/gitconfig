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

Rebases a single commit without opening interactive editor.
<br> `[interactive_command]` is the `pick/edit/reword/fix` etc. command in the interactive editor.

```bash
# Alias for:
git rebase -i [commit_hash]~
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

### `git pull-all-branches`

Pulls all remote branches.

```bash
# Alias for:
git fetch -p    # Update + prune remote branches
echo "From $(git remote get-url origin)"
for remote in `git branch -r | grep -v \" -> \"`; do
    branch=${remote#origin/}
    branch_not_exists=$(git show-ref refs/heads/$branch)

    git fetch --update-head-ok origin $branch:$branch 2>&1  # Pulls, allowing pulls to current branch
        | grep -v "From"                                    # Removes repeated "From [REMOTE_URL]"

    [ -z \"$branch_not_exists\" ]
        && git branch --quiet -u $remote $branch            # Sets upstream as 'git fetch' doesn't
done
```

<br>

### `git pull-force`

Pulls and overwrite current local branch.

```bash
# Alias for:
git fetch --all
git reset --hard "origin/$(git branch --show-current)"
```
