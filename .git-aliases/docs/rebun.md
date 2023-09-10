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
