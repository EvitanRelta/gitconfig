### `git addf [filenames]`

Fuzzy add filenames.

Prefix and suffix each filename with `*` to match every file that contains the
keyword.

```bash
# Alias for:
fuzzy_filenames=$(echo "$@" | sed -E "s/([^ ]+)/\*\\1\*/g")
git add "$fuzzy_filenames"
```
