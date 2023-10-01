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
