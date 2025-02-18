### `git rebase-preserve [same-options-as-rebase]`

Exactly the same as `rebase`, but preserves the author & committer names and dates of commits.

```bash
# Alias for (linebreaks for display purpose only):
git -c rebase.instructionFormat='%s%nexec
    git copy-commit-metadata
        --committer
        --author
        --committer-date
        --author-date
    %H' rebase [same-options-as-rebase]

# Example usage:
git rebase-preserve -i --rebase-merges @~5
```
