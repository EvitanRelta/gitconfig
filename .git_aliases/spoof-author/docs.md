### `git spoof-author [name] [email]`

Changes the author/commiter names and emails of the previous commit.

```bash
# Alias for:
GIT_COMMITTER_NAME="[name]" GIT_COMMITTER_EMAIL="[email]" git commit --amend --no-edit --author="[name] <[email]>"
```
