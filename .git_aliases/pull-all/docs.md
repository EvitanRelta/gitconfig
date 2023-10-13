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
