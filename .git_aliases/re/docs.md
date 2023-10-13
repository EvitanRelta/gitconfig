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
